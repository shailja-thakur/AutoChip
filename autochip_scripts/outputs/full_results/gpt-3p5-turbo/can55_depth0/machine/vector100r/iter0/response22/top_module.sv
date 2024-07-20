module top_module (
	input [99:0] in,
	output reg [99:0] out
);
  
  always_comb begin
    for (int i = 0; i < $bits(out); i = i + 1) begin
      out[i] <= in[$bits(out) - i - 1];
    end
  end
  
endmodule
