void I2vsV() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraph *gr = new TGraph("I2vsV.txt","%lg %lg");
   gr->SetTitle("I^2 vs V");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetLineColor(9);
   gr->SetMarkerSize(1.5);

   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetXaxis()->SetTitleSize(0.045);

   gr->GetYaxis()->SetTitle("Corrente^2 (A)");
   gr->GetYaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitleSize(0.045);

   gr->Draw("AP");

   const int N_Points = 60;
   //Fit del grafico
   double x_fit_start = gr->GetX()[0];
   double x_fit_end = gr->GetX()[N_Points-1];
   double x_plot_start = gr->GetXaxis()->GetXmin();
   double x_plot_end = gr->GetXaxis()->GetXmax();

   TF1 *fit_func = new TF1("fit_func", "pol1", x_plot_start, x_plot_end);   
   gr->Fit(fit_func, "R", "", x_fit_start, x_fit_end);
   //per parametri fit
   double intercept = fit_func->GetParameter(0);
   double slope = fit_func->GetParameter(1);
   TString fit_label = TString::Format(
    "#splitline{Fit Lineare:}{y = (%.3e) + (%.3e)x}",
    intercept, slope
);

   //legenda
   TLegend *tl = new TLegend(0.1, 0.9, 0.4, 0.75);
   tl->AddEntry(gr, "Dati Misurati", "p");
   tl->AddEntry(fit_func, fit_label.Data(), "l");

   tl->Draw();
   fit_func->Draw("SAME");
   c1->Update();
   c1->SaveAs("I2vsV.jpg");
}