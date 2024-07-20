module population_count (
	input [254:0] in,
	output reg [7:0] out
);
	
	always @(*) begin
		out = 0;
		for (int i = 0; i < 255; i = i + 1) begin
			if (in[i] == 1'b1) begin
				out = out + 1;
			end
		end
	end
	
endmodule
module top_module (
	input [254:0] in,
	output reg [7:0] out
);
	
	population_count population_count_inst (
		.in(in),
		.out(out)
	);
	
endmodule
