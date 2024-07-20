module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;

	// Define state register
	reg [1:0] current_state;
	reg [1:0] next_state;

	// Define output register
	reg output_reg;

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Output logic
	always @(current_state, in) begin
		case (current_state)
			A: begin
				if (in) begin
					next_state <= B;
				end else begin
					next_state <= A;
				end
			end

			B: begin
				if (in) begin
					next_state <= B;
				end else begin
					next_state <= C;
				end
			end

			C: begin
				if (in) begin
					next_state <= D;
				end else begin
					next_state <= A;
				end
			end

			D: begin
				if (in) begin
					next_state <= B;
				end else begin
					next_state <= C;
				end
			end
		endcase
	end

	// Output register assignment
	always @(posedge clk) begin
		if (current_state == D) begin
			output_reg <= 1;
		end else begin
			output_reg <= 0;
		end
	end

	// Assign output
	assign out = output_reg;

endmodule
