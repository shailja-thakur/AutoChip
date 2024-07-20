module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

reg [2:0] state;
always @(posedge clk) begin
	if (reset) begin
		state <= A;
	end else begin
		case(state)
			A: begin
				if (w == 0)
					state <= B;
				else
					state <= A;
			end
			B: begin
				if (w == 1)
					state <= D;
				else
					state <= C;
			end
			C: begin
				if (w == 1)
					state <= D;
				else
					state <= E;
			end
			D: begin
				if (w == 1)
					state <= A;
				else
					state <= F;
			end
			E: begin
				if (w == 1)
					state <= D;
				else
					state <= E;
			end
			F: begin
				if (w == 1)
					state <= D;
				else
					state <= C;
			end
		endcase
	end
end

assign z = (state == E || state == F);

endmodule
