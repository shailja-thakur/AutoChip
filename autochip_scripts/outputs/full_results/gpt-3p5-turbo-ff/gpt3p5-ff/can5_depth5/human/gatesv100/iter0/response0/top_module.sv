module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

  // Logic to calculate out_both
  generate
    genvar i;
    for (i = 0; i < 99; i = i + 1) begin
      assign out_both[i] = in[i] & in[i+1];
    end
  endgenerate
  
  // Logic to calculate out_any
  generate
    assign out_any[99] = in[98];
    for (i = 98; i > 0; i = i - 1) begin
      assign out_any[i] = in[i] | in[i-1];
    end
  endgenerate
  
  // Logic to calculate out_different
  generate
    assign out_different[0] = in[99] ^ in[98];
    for (i = 1; i < 100; i = i + 1) begin
      assign out_different[i] = in[i-1] ^ in[i];
    end
  endgenerate
  
endmodule
