module top_module (
	input clk,
	input in,
	output logic out
);

  reg d;
  wire xor_out;

  assign xor_out = in ^ out;
  
  always @(posedge clk) begin 
    d <= xor_out;
    out <= d;
  end
  
endmodule
