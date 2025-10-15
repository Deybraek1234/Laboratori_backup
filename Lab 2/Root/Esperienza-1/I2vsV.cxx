void I2vsV() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraphErrors *gr = new TGraphErrors("I2vsV.txt","%lg %lg %lg %lg");
   gr->SetTitle("I^2 vs V");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetLineColor(9);
   gr->SetMarkerSize(1.5);

   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetXaxis()->SetTitleSize(0.047);

   gr->GetYaxis()->SetTitle("Corrente^2 (mA^2)");
   gr->GetYaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitleSize(0.047);

   gr->Draw("AEP");


  //create fake graph to do unweighted plot 
   TGraph *g1 = new TGraph("I2vsV.txt","%lg %lg");
   //numero di punti per il fit
   const int N_Points = 59;
   const int start_points = 22;
   //Fit del grafico
   double x_fit_start = g1->GetX()[start_points-1];
   double x_fit_end = g1->GetX()[N_Points -1];
   double x_plot_start = g1->GetXaxis()->GetXmin();
   double x_plot_end = g1->GetXaxis()->GetXmax();   
   TF1 *fit_func = new TF1("fit_func", "pol1", x_plot_start, x_plot_end); 
   g1->Fit(fit_func, "R", "",x_fit_start, x_fit_end);
   //per parametri fit
   double intercept = fit_func->GetParameter(0);
   double slope = fit_func->GetParameter(1);
   TString fit_label = TString::Format(
    "#splitline{Fit Lineare:}{y = (%.3e)x + (%.3e)}",
    slope, intercept
);
   fit_func->SetLineColor(48);


   //legenda
   TLegend *tl = new TLegend(0.1, 0.9, 0.43, 0.75);
   tl->AddEntry(gr, "Dati Misurati", "p");
   tl->AddEntry(fit_func, fit_label.Data(), "l");
   tl->Draw();

   fit_func->Draw("SAME");
   c1->Update();
   c1->SaveAs("I2vsV.eps");
}