module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [3:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0;
		end else begin
			case (state)
				4'b0: begin  // State A
					if (s) begin
						state <= 4'b1;  // Transition to State B
					end else begin
						state <= 4'b0;
					end
				end
				4'b1: begin  // State B
					if (w) begin
						state <= 4'b10;  // Transition to State S11
					end else begin
						state <= 4'b100;  // Transition to State S10
					end
				end
				4'b10: begin  // State C
					if (w) begin
						state <= 4'b10;  // Transition to State S11
					end else begin
						state <= 4'b100;  // Transition to State S10
					end
				end
				4'b100: begin  // State S10
					if (w) begin
						state <= 4'b1000;  // Transition to State S21
					end else begin
						state <= 4'b10000;  // Transition to State S20
					end
				end
				4'b1000: begin  // State S11
					if (w) begin
						state <= 4'b10000;  // Transition to State S20
					end else begin
						state <= 4'b100000;  // Transition to State S21
					end
				end
				4'b10000: begin  // State S20
					state <= 4'b1;  // Transition to State B
				end
				4'b100000: begin  // State S21
					if (w) begin
						state <= 4'b10;  // Transition to State C
					end else begin
						state <= 4'b1;  // Transition to State B
					end
				end
				4'b1000000: begin  // State S22
					if (w) begin
						state <= 4'b1;  // Transition to State B
					end else begin
						state <= 4'b10;  // Transition to State C
					end
				end
				default: state <= 4'b0;
			endcase
		end
	end

	always @(state) begin
		case (state)
			4'b10000, 4'b100000, 4'b1000000, 4'b1: begin
				z <= 1'b1;
			end
			default: begin
				z <= 1'b0;
			end
		endcase
	end

endmodule
