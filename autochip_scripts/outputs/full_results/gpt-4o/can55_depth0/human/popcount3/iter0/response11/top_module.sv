module top_module (
	input [2:0] in,
	output [1:0] out
);

	reg [1:0] count;
	integer i;

	always @(*) begin
		count = 0;
		for (i = 0; i < 3; i = i + 1) begin
			if (in[i])
				count = count + 1;
		end
	end

	assign out = count;

endmodule
