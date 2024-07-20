module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f, g;
reg [1:0] state, next_state;
wire reset;

assign reset = ~resetn;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge reset) begin
	if (!reset) begin
		state <= A;
		f <= 0;
		g <= 0;
	end else begin
		state <= next_state;
		f <= (state == B) ? 1'b1 : 1'b0;
	end
end

always @(state, x, y) begin
	next_state = state;
	case (state)
		A: if (x == 1'b1) next_state = B;
		B: if (x == 1'b0) next_state = C;
		C: if (x == 1'b1) next_state = D;
		D: if (y == 1'b0) next_state = C;
		   else if ((y == 1'b1) && (next_state != D)) next_state = D;
	endcase
end

assign g = (state == D) ? 1'b1 : 1'b0;

endmodule
