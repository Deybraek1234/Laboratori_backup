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
   gr->GetYaxis()->SetTitle("Corrente (A)");
   gr->GetYaxis()->CenterTitle(true);
   gr->Draw("AP");

   //const int N_Points = 14;
   //Fit del grafico
   //Double_t x_fit_start = gr->GetX()[0];
   //Double_t x_fit_end = gr->GetX()[N_Points-1];
   //Double_t x_plot_start = gr->GetXaxis()->GetXmin();
   //Double_t x_plot_end = gr->GetXaxis()->GetXmax();

   //TF1 *fit_func = new TF1("fit_func", "pol1", x_plot_start, x_plot_end);   
   //gr->Fit(fit_func, "R", "", x_fit_start, x_fit_end);
   
   TF1 *line = new TF1("line_func", "[0]+[1]*x", -0.099998, 1.5);
   line->SetParameter(0,0.001069);
   line->SetParameter(1,0.4708);
   line->SetLineColor(49);
   gr->Draw("AP");
   line->Draw("SAME");
   c1->Update();
   c1->SaveAs("graficozoomato.jpg");
}