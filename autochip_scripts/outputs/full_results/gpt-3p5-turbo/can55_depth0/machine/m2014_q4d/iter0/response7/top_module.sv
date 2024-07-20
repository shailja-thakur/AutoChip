module top_module (
  input clk,
  input logic in,
  output logic out
);
  logic prev_out;
  
  always_ff @(posedge clk)
    prev_out <= out;
  
  always_comb
    out = in ^ prev_out;
  
endmodule
