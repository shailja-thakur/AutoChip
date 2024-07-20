module top_module (
	input clk,
	input x,
	output z
);
  
  reg dff1, dff2, dff3;
  wire xor_out, and_out, or_out;
  
  always @(posedge clk) begin
    dff1 <= x ^ dff1;
    dff2 <= ~dff2 & x;
    dff3 <= ~dff3 | x;
  end
  
  assign xor_out = dff1 ^ dff1; 
  assign and_out = dff2 ^ ~dff2;
  assign or_out = dff3 ^ ~dff3;
  
  assign z = xor_out ^ and_out ^ or_out;
  
endmodule
