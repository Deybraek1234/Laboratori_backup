#include<string>

void grafico_no_fit() {

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

   //draw everything
   g1->Draw("SAME AP");
   cv->Update();
   cv->SaveAs((nome_grafico + ".eps").Data());
}