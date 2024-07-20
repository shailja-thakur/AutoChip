module top_module (
	input clk,
	input in,
	output logic out
);

  reg d;
  logic xor_output;
  
  always @(posedge clk) begin
    d = xor_output;
  end
  
  assign xor_output = in ^ out;
  
endmodule
