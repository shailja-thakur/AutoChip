module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state, next_state;

	parameter A = 3'b000; // State A
	parameter B = 3'b001; // State B
	parameter C = 3'b010; // State C
	parameter D = 3'b011; // State D
	parameter E = 3'b100; // State E
	parameter F = 3'b101; // State F

	always @(posedge clk or posedge reset) begin
		if (reset) begin // Synchronous reset
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state or w) begin
		case(state)
			A: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			C: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			D: begin
				if (w) begin
					next_state = F;
				end else begin
					next_state = A;
				end
			end
			E: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			F: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
		endcase
	end

	assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
