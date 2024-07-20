module top_module(
  input a,
  input b,
  input c,
  output out
);
  
  wire [3:0] k_map;
  assign k_map[0] = (~a & ~b & ~c) ? 1'b1 : 1'b0; // 00
  assign k_map[1] = (~a & ~b & c) ? 1'b1 : 1'b0;  // 01
  assign k_map[2] = (a & b & c) ? 1'b1 : 1'b0;    // 11
  assign k_map[3] = (a & ~b & c) ? 1'b1 : 1'b0;   // 10
  
  assign out = |k_map;
    
endmodule
