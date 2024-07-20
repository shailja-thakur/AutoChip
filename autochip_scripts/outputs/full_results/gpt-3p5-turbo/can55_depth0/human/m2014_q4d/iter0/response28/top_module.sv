module top_module (
  input clk,
  input in,
  output logic out
);
  
  logic xor_output;
  logic d_input;
  
  assign xor_output = in ^ out;
  always_ff @(posedge clk)
    d_input <= xor_output;
    
  always_ff @(posedge clk)
    out <= d_input;
  
endmodule
