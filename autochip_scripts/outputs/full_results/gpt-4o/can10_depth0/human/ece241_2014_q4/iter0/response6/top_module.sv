module top_module (
	input clk,
	input x,
	output z
);

  // Internal signals for DFF outputs
  reg dff1_out, dff2_out, dff3_out;
  
  // Internal signals for gate outputs
  wire xor_out, and_out, or_out;
  
  // XOR gate
  assign xor_out = x ^ dff1_out;
  
  // AND gate
  assign and_out = x & ~dff2_out;
  
  // OR gate
  assign or_out = x | ~dff3_out;
  
  // D flip-flops
  always @(posedge clk) begin
    dff1_out <= xor_out;
    dff2_out <= and_out;
    dff3_out <= or_out;
  end
  
  // XNOR gate
  assign z = ~((dff1_out ^ dff2_out) ^ dff3_out);

endmodule
