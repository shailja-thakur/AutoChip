module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
wire g1, g2, g3;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= A;
	else begin
		case (state)
			A: if (r[1] && ~r[2] && ~r[3]) state <= B;
			   else if (~r[1] && r[2] && ~r[3]) state <= C;
			   else if (~r[1] && ~r[2] && ~r[3]) state <= D;
			   else state <= A;
			B: if (g1 && r[1]) state <= B;
			   else if (g1 && ~r[1]) state <= A;
			   else state <= B;
			C: if (g2 && r[2]) state <= C;
			   else if (g2 && ~r[2]) state <= A;
			   else state <= C;
			D: state <= A;
		endcase
	end
end

assign g[1] = (state == B) ? g1 : 1'b0;
assign g[2] = (state == C) ? g2 : 1'b0;
assign g[3] = (state == A) ? g3 : 1'b0;

endmodule
