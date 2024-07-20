module top_module(
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);
  
  reg xor_result;
  
  // Assigning the XOR result to out_assign using an assign statement
  assign out_assign = a ^ b;
  
  // Assigning the XOR result to out_always_comb using an always_comb block
  always_comb begin
    out_always_comb = a ^ b;
  end
  
  // Assigning the XOR result to out_always_ff using an always_ff block
  always @(posedge clk) begin
    out_always_ff <= a ^ b;
  end

endmodule
