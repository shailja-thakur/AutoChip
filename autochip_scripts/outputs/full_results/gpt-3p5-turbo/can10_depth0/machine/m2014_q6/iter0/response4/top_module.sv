module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// State definitions
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

reg [2:0] state;
always @ (posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else begin
		case (state)
			A: begin
				if (w)
					state <= A;
				else
					state <= B;
			end
			B: begin
				if (w)
					state <= D;
				else
					state <= C;
			end
			C: begin
				if (w)
					state <= D;
				else
					state <= E;
			end
			D: begin
				if (w)
					state <= A;
				else
					state <= F;
			end
			E: begin
				if (w)
					state <= D;
				else
					state <= E;
			end
			F: begin
				if (w)
					state <= D;
				else
					state <= C;
			end
		endcase
	end
end

always @ (state) begin
	case (state)
		A, B, C, D: z <= 1'b0;
		E, F: z <= 1'b1;
	endcase
end

endmodule
