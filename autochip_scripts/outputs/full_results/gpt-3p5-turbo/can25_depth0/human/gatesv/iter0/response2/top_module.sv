module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
  
  wire both_2, both_1, both_0;

  //check if bit 2 & 3 are both 1
  assign both_2 = (in[2] == 1) && (in[3] == 1);  
  
  //check if bit 1 & 2 are both 1
  assign both_1 = (in[1] == 1) && (in[2] == 1);
  
  //check if bit 0 & 1 are both 1
  assign both_0 = (in[0] == 1) && (in[1] == 1);
  
  //output both results
  assign out_both = {both_2, both_1, both_0};   
    
  wire any_2, any_1, any_0;

  //check if bit 2 or 1 are 1
  assign any_2 = (in[2] == 1) || (in[1] == 1);
  
  //check if bit 1 or 0 are 1
  assign any_1 = (in[1] == 1) || (in[0] == 1);
  
  //check if bit 0 or 3 are 1
  assign any_0 = (in[0] == 1) || (in[3] == 1);
  
  //output any results
  assign out_any = {any_2, any_1, any_0};
  
  wire different_2, different_1, different_0;
  
  //check if bit 2 is different from bit 3
  assign different_2 = (in[2] != in[3]);
  
  //check if bit 1 is different from bit 2
  assign different_1 = (in[1] != in[2]);
  
  //check if bit 0 is different from bit 3
  assign different_0 = (in[0] != in[3]);
  
  //output different results
  assign out_different = {different_2, different_1, different_0, different_2};
  
endmodule
