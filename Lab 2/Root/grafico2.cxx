void grafico2() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraphErrors *gr = new TGraphErrors("grafico2.txt","%lg %lg %lg %lg");
   gr->SetTitle("Curva Caratteristica V<1");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetLineColor(9);
   gr->SetMarkerSize(1.5);

   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetXaxis()->SetTitleSize(0.045);

   gr->GetYaxis()->SetTitle("Corrente (A)");
   gr->GetYaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitleSize(0.045);

   gr->Draw("AP");

   //create fake graph to do unweighted plot 
   TGraph *g1 = new TGraph("grafico2.txt","%lg %lg");
   //numero di punti
   const int N_Points = 14;
   //Fit del grafico
   double x_fit_start = g1->GetX()[0];
   double x_fit_end = g1->GetX()[N_Points-1];
   double x_plot_start = g1->GetXaxis()->GetXmin();
   double x_plot_end = g1->GetXaxis()->GetXmax();
   TF1 *fit_func = new TF1("fit_func", "pol1", x_plot_start, x_plot_end);   
   g1->Fit(fit_func, "R", "", x_fit_start, x_fit_end);
   //per parametri fit
   double intercept = fit_func->GetParameter(0);
   double slope = fit_func->GetParameter(1);
   TString fit_label = TString::Format(
    "#splitline{Fit Lineare:}{y = (%.3e) + (%.3e)x}",
    intercept, slope
);


   //linea accensione lampadina
   double y_min = gr->GetYaxis()->GetXmin();
   double y_max = gr->GetYaxis()->GetXmax();
   double x_point = 0.331;
   TLine* line = new TLine(x_point, y_min, x_point, y_max);
   line->SetLineColor(34);
   line->SetLineWidth(2);
   line->Draw();

   //legenda
   TLegend *Tl = new TLegend(0.1, 0.9, 0.35, 0.75);
   Tl->AddEntry(gr, "Dati Misurati", "ep");
   Tl->AddEntry(fit_func, fit_label, "l");
   Tl->AddEntry(line, "Accensione Lampadina", "l");
   Tl->Draw();

   //draw everything
   fit_func->Draw("SAME");
   c1->Update();
   c1->SaveAs("graficozoomato1.jpg");
}