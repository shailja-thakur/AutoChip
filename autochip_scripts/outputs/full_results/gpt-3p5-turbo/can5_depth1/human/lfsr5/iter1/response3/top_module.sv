module tap5(
	input clk, 
	input reset, 
	input [4:0] state_in, 
	output reg tap5, 
	output reg [4:0] state_out
);
always @(posedge clk) begin
	if(reset)
		tap5 <= 0;
	else
		tap5 <= state_in[4] ^ state_in[2];
end

endmodule
module tap3(
	input clk, 
	input reset, 
	input [4:0] state_in, 
	output reg tap3, 
	output reg [4:0] state_out
);
always @(posedge clk) begin
	if(reset)
		tap3 <= 0;
	else
		tap3 <= state_in[4] ^ state_in[2] ^ state_in[0];
end
endmodule
module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

reg [4:0] state;

tap3 tap3_unit(
	.clk(clk),
	.reset(reset),
	.state_in(state),
	.tap3(q[0]),
	.state_out(state)
);

tap5 tap5_unit(
	.clk(clk),
	.reset(reset),
	.state_in(state),
	.tap5(q[4]),
	.state_out(state)
);


always @(posedge clk or posedge reset) begin
	if (reset)
		q <= 1;
	else
		q <= state;
end
	
endmodule
