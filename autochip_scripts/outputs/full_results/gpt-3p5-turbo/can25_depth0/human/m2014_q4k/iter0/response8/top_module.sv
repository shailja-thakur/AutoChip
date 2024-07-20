module shift_register (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] flop;
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			flop <= 4'b0000;
		else
			flop <= {in, flop[3:1]};
	end
	assign out = flop[0];
endmodule
module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	shift_register register (
		.clk(clk),
		.resetn(resetn),
		.in(in),
		.out(out)
	);
endmodule
