module top_module (
	input [254:0] in,
	output reg [7:0] out
);

	// Intermediate signals
	reg [7:0] count;

	always @(*) begin
		count = 0;
		for (int i = 0; i < 255; i = i + 1) begin
			if (in[i] == 1'b1)
				count = count + 1;
		end
	end

	assign out = count;

endmodule
