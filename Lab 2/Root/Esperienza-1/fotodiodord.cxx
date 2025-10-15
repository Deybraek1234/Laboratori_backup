void fotodiodord() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   TGraphErrors *gr = new TGraphErrors("fotodiodord.txt","%lg %lg %lg %lg");
   gr->SetTitle("Resistenza Dinamica");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetLineColor(9);
   gr->SetMarkerSize(1.5);

   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetXaxis()->SetTitleSize(0.047);

   gr->GetYaxis()->SetTitle("Resistenza Dinamica (Ohm)");
   gr->GetYaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitleSize(0.047);

   gr->Draw("AP");

   gr->Draw("AP");
   c1->Update();
   c1->SaveAs("fotodiodord.eps");
}

//const int mpt = 9999;
//  float x1[mpt];
//   float x2[mpt];
//   float x3[mpt];
//   float x4[mpt];
//   float x4bis[mpt];
//   float rmax;
//   float xmax;
//   xmax=0;
//   rmax=0;
   //float n;
   //cout<<"Inserisci quanti sigma desideri"<<endl;
   //cin>>n;

//   int npt = 0;
   

   // read data file
//   ifstream in;
//   in.open("date.txt");      //INSERISCI IL NOME DEL FILE CON I DATI!!!
//   while (1) {

//      in >> x1[npt] >> x2[npt] >> x3[npt] >> x4[npt];

//      if ( ! in.good() ) break;

      //cout << "x = " << x1[npt] << " y = " << x2[npt] << " ex = " << x3[npt]  << "ey =" << x4[npt] << endl;

//      npt++;
//   }