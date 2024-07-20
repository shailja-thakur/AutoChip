module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= A;
		z <= 1'b0;
	end else begin
		case (state)
			A: begin
				if (w) begin
					state <= A;
				end else begin
					state <= B;
				end
			end
			B: begin
				if (w) begin
					state <= D;
				end else begin
					state <= C;
				end
			end
			C: begin
				if (w) begin
					state <= D;
				end else begin
					state <= E;
				end
			end
			D: begin
				if (w) begin
					state <= A;
				end else begin
					state <= F;
				end
			end
			E: begin
				if (w) begin
					state <= D;
				end else begin
					state <= E;
				end
			end
			F: begin
				if (w) begin
					state <= D;
				end else begin
					state <= C;
				end
			end
			default: state <= A;
		endcase
	end
end

always @(state) begin
	if (state == E || state == F) begin
		z <= 1'b1;
	end else begin
		z <= 1'b0;
	end
end

endmodule
