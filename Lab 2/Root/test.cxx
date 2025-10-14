void grafico2_SimpleOLS() {
   TCanvas *c1 = new TCanvas("c1","Bruciamo le lampadine :) (graph 2)",1600,1000);
   c1->SetGrid();
   c1->GetFrame()->SetBorderSize(12);
  
   // TGraphErrors reads: X, Y, dX, dY
   TGraphErrors *gr = new TGraphErrors("grafico2.txt","%lg %lg %lg %lg");
   
   // ... (Graph Styling setup) ...
   gr->SetTitle("Curva Caratteristica V<1");
   gr->SetMarkerColor(2);
   gr->SetMarkerStyle(5);
   gr->SetMarkerSize(1.5);
   gr->GetXaxis()->SetTitle("Potenziale (V)");
   gr->GetXaxis()->CenterTitle(true);
   gr->GetYaxis()->SetTitle("Corrente (A)");
   gr->GetYaxis()->CenterTitle(true);
   
   gr->Draw("AP"); // Draw with original error bars
   
   // =======================================================
   // 💡 SIMPLER OLS FIT METHOD 💡
   // =======================================================
   
   // 1. Define the fit range
   const int N_Points = 14;
   Double_t x_fit_start = gr->GetX()[0];
   Double_t x_fit_end = gr->GetX()[N_Points-1];

   // 2. Create the TLinearFitter for a linear function ([0] + [1]*x)
   TLinearFitter *fitter = new TLinearFitter(2);
   fitter->SetFormula("[0] + [1]*x"); // Define the pol1 function

   // 3. Perform the fit using the OLS option ("unweighted")
   //    TLinearFitter::AssignData(TGraphErrors *g, Option_t *option)
   //    Option "unweighted" tells it to ignore the errors (dY) in the fit calculation.
   fitter->AssignData(gr, "unweighted");
   fitter->Fit(x_fit_start, x_fit_end);

   // 4. Get the result as a TF1 object to draw it
   TF1 *fit_func_ols = fitter->Get==FitFunction();
   fit_func_ols->SetLineColor(9);
   fit_func_ols->SetRange(gr->GetXaxis()->GetXmin(), gr->GetXaxis()->GetXmax());
   fit_func_ols->Draw("SAME");
   
   // --- Your manually defined line (optional) ---
   TF1 *line = new TF1("line_func", "[0]+[1]*x", -0.099998, 1.5);
   line->SetParameter(0,0.001069);
   line->SetParameter(1,0.4708);
   line->SetLineColor(49);
   line->Draw("SAME");

   c1->Update();
   c1->SaveAs("graficozoomato1.jpg");
}