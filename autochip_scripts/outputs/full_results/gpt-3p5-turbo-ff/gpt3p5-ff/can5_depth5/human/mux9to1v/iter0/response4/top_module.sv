module top_module (
  input [15:0] a,
  input [15:0] b,
  input [15:0] c,
  input [15:0] d,
  input [15:0] e,
  input [15:0] f,
  input [15:0] g,
  input [15:0] h,
  input [15:0] i,
  input [3:0] sel,
  output logic [15:0] out
);
   
  assign out = (sel == 4'h0) ? a :
               (sel == 4'h1) ? b :
               (sel == 4'h2) ? c :
               (sel == 4'h3) ? d :
               (sel == 4'h4) ? e :
               (sel == 4'h5) ? f :
               (sel == 4'h6) ? g :
               (sel == 4'h7) ? h :
               (sel >= 4'h8 && sel <=4'hF) ? 16'd1 :
               16'd0;
  
endmodule
