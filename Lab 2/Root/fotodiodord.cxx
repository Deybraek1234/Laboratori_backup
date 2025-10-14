void fotodiodord() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraphErrors *gr = new TGraphErrors("fotodiodord.txt","%lg %lg");
   gr->SetTitle("Voltagio vs Rd");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetLineColor(9);
   gr->SetMarkerSize(1.5);

   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetXaxis()->SetTitleSize(0.045);

   gr->GetYaxis()->SetTitle("Resistenza Dinamica (R)");
   gr->GetYaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitleSize(0.045);

   gr->Draw("AP");

   gr->Draw("AP");
   c1->Update();
   c1->SaveAs("fotodiodord.eps");
}