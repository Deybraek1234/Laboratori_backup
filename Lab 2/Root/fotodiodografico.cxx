void fotodiodografico() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraphErrors *gr = new TGraphErrors("fotodiodografico.txt","%lg %lg");
   gr->SetTitle("Corrente Fotodiodo");
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


   double y_min = gr->GetYaxis()->GetXmin();
   double y_max = gr->GetYaxis()->GetXmax();
   double x_point = 0.331;
   TLine* line = new TLine(x_point, y_min, x_point, y_max);
   line->SetLineColor(34);
   line->SetLineWidth(2);

   TLegend *Tl = new TLegend(0.1, 0.9, 0.35, 0.80);
   Tl->AddEntry(gr, "Dati Misurati", "p");
   Tl->AddEntry(line, "Accensione Lampada", "l");

   gr->Draw("AP");
   line->Draw("SAME");
   Tl->Draw("Same");
   c1->Update();
   c1->SaveAs("fotodiodografico.jpg");
}