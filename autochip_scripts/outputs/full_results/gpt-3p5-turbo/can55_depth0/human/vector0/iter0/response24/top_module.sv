module top_module(
    input [2:0] vec, 
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);
  
  assign outv = vec;  // Assign vec to outv
  
  assign o0 = vec[0]; // Assign vec[0] to o0
  
  assign o1 = vec[1]; // Assign vec[1] to o1
  
  assign o2 = vec[2]; // Assign vec[2] to o2

endmodule
