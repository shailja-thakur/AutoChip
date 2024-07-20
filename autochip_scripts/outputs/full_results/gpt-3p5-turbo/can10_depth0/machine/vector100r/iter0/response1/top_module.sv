module top_module (
	input [99:0] in,
	output reg [99:0] out
);

always_comb begin
	for (integer i=0; i<$size(out); i=i+1) begin
		out[i] = in[$size(out)-1-i];
	end
end

endmodule
