module top_module (
	input [254:0] in,
	output reg [7:0] out
);
	always @* begin
		integer count;
		out = 0;
		for (count = 0; count < 255; count = count + 1) begin
			if (in[count] == 1'b1) begin
				out = out + 1;
			end
		end
	end
endmodule
