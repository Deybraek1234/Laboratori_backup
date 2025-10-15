#include<string>

void fit_grafico() {

   //nome file grafico
   //const TString nome_grafico = "grafico";
   TString nome_grafico;
   std::cout <<"Nome Grafico:";
   std::cin >> nome_grafico;


   //nome file dati (da leggere)
   TString nome_punti;
   std::cout <<"Data file name:";
   std::cin  >> nome_punti;

   //number of points
   const int number_point = 99999;

   //initialize array and counter for loading array
   double x[number_point];
   double y[number_point];
   double errx[number_point];
   double erry[number_point];
   int n;
   //read in file
   ifstream in;
   in.open((nome_punti + ".txt").Data());
   while(1) {
      in >> x[n] >> y[n] >> errx[n] >> erry[n];
      if ( ! in.good()) break;
      n++;
   }

   TCanvas *cv = new TCanvas("c1", nome_grafico);
   cv->SetGrid();
   cv->GetFrame()->SetBorderSize(12);

   TGraphErrors *g1 = new TGraphErrors(n, x, y, errx, erry);
   g1->SetTitle(nome_grafico);
   //punti
   g1->SetMarkerColor(2);  //red
   g1->SetMarkerStyle(5);  //x
   g1->SetMarkerSize(1.5); //abbastanza grandi
   //xaxis
   g1->GetXaxis()->SetTitle("Placeholder");
   g1->GetXaxis()->CenterTitle(true);
   //g1->GetXaxis()->SetTitleSize();
   //yaxis
   g1->GetYaxis()->SetTitle("Placeholder");
   g1->GetYaxis()->CenterTitle(true);
   //g1->GetYaxis()->SetTitleSize();

   //per fare il fit (unweighted)
   int fit_tutti_punti;
   std::cout <<"Fare fit tutti punti?[1-si/0-custom range]";
   std::cin >> fit_tutti_punti;
   TGraph *gfake = new TGraph(n, x, y);

   int i;
   int j;
   double x_start;
   double x_end;

//if statement for checking if fit all data
   if(fit_tutti_punti == 1){
   x_start = x[0];
   x_end = x[number_point-1];
} else if (fit_tutti_punti == 0){
   std::cout <<"Numero di punto iniziale:";
   std::cin >> i;
   x_start = x[i-1];
   std::cout <<"Numero di punto Finale:";
   std::cin >> j;
   x_end = x[j-1];
} else {
   std::cout<<"Not Number in valid range";
   exit(0);
}

   TF1 *fit_func = new TF1("fit_func", "pol1", g1->GetXaxis()->GetXmin(), g1->GetXaxis()->GetXmax());
   gfake->Fit(fit_func, "R", "", x_start, x_end);
   double slope = fit_func->GetParameter(1);
   double intercept = fit_func->GetParameter(0);
   fit_func->SetLineColor(48);

   //pendenza e intercetta per legenda
   TString fit_label = TString::Format(
    "#splitline{Fit Lineare:}{y = (%.3e)x + (%.3e)}",
    slope, intercept
   );

   //legenda
   TLegend *Tl = new TLegend(0.1, 0.9, 0.35, 0.75);
   Tl->AddEntry(g1, "Dati Misurati", "ep");
   Tl->AddEntry(fit_func, fit_label, "ep");

   //draw everything
   g1->Draw("SAME AP");
   fit_func->Draw("SAME");
   Tl->Draw("SAME");
   cv->Update();
   cv->SaveAs((nome_grafico + ".eps").Data());
}