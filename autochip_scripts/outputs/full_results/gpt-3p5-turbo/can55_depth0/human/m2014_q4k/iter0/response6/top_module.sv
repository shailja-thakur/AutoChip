module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] flop;

always @(posedge clk, negedge resetn) begin
	if (!resetn)
		flop <= 4'b0;
	else
		flop <= {flop[2:0], in};
end

assign out = flop[3];

endmodule
