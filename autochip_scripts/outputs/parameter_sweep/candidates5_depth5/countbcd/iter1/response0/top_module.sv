module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

reg [3:1] next_ena;
reg [15:0] next_q;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		q <= 0;
		ena <= 0;
	end else begin
		ena <= next_ena;
		q <= next_q;
	end
end

always @* begin
	next_ena[1] = (q[3:0] == 9);
	next_ena[2] = (q[7:4] == 9);
	next_ena[3] = (q[11:8] == 9);

	next_q[3:0] = q[3:0] + 1;
	next_q[7:4] = q[7:4] + (next_ena[1] && (q[3:0] == 9));
	next_q[11:8] = q[11:8] + (next_ena[2] && (q[7:4] == 9));
	next_q[15:12] = q[15:12] + (next_ena[3] && (q[11:8] == 9));
end

endmodule
