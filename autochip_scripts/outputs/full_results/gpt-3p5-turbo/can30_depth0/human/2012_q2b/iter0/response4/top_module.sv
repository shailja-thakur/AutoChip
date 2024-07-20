module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// State Flip-Flop Definitions
	reg y_ff1;
	reg y_ff3;

	// State Equations
	always @(posedge w) begin
		case(y)
			6'b000001: begin
				y_ff1 <= 1'b0;
				y_ff3 <= 1'b0;
			end

			6'b000010: begin
				y_ff1 <= 1'b0;
				y_ff3 <= 1'b0;
			end

			6'b000100: begin
				y_ff1 <= 1'b0;
				y_ff3 <= 1'b1;
			end

			6'b001000: begin
				y_ff1 <= 1'b0;
				y_ff3 <= 1'b0;
			end

			6'b010000: begin
				y_ff1 <= 1'b1;
				y_ff3 <= 1'b0;
			end

			6'b100000: begin
				y_ff1 <= 1'b1;
				y_ff3 <= 1'b0;
			end

			default: begin
				y_ff1 <= 1'b0;
				y_ff3 <= 1'b0;
			end
		endcase
	end

	// Output Assignments
	assign Y1 = y_ff1;
	assign Y3 = y_ff3;

endmodule
