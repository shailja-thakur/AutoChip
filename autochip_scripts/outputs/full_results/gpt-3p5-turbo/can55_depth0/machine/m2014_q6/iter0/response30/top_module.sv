module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	else begin
		case(state)
			A: begin
				if (w == 1'b0)
					state <= B;
				else
					state <= A;
			end
			B: begin
				if (w == 1'b1)
					state <= D;
				else
					state <= C;
			end
			C: begin
				if (w == 1'b1)
					state <= D;
				else
					state <= E;
			end
			D: begin
				if (w == 1'b1)
					state <= A;
				else
					state <= F;
			end
			E: begin
				if (w == 1'b1)
					state <= D;
				else
					state <= E;
			end
			F: begin
				if (w == 1'b1)
					state <= D;
				else
					state <= C;
			end
		endcase
	end
end

always @(state) begin
	if (state == E || state == F)
		z <= 1'b1;
	else
		z <= 1'b0;
end

endmodule
