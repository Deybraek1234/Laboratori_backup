void macro1() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 1)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraphErrors *gr = new TGraphErrors("bruciarelampa.txt","%lg %lg %lg %lg");
   gr->SetTitle("Curva Caratteristica Lampadina");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetLineColor(9);
   gr->SetMarkerSize(1.5);
   gr->Draw("AP");
   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitle("Corrente (A)");
   gr->GetYaxis()->CenterTitle(true);

   Double_t y_min = gr->GetYaxis()->GetXmin();
   Double_t y_max = gr->GetYaxis()->GetXmax();
   Double_t x_point = 0.331;

   TLine* line = new TLine(x_point, y_min, x_point, y_max);
   line->SetLineStyle(kDotted);
   line->SetLineColor(34);
   line->SetLineWidth(2);

   gr->Draw("AP");
   line->Draw("SAME");
   c1->Update();
   c1->SaveAs("bruciarelampa.jpg");
}