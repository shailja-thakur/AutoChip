module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {
		A, B, C, D
	} state;

	// Define the state register and next state
	reg state current_state;
	reg state next_state;

	// Define the output register
	reg out_reg;

	// State transition logic
	always @(posedge clk or posedge reset) begin
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
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
		endcase
	end

	// Output register logic
	always @(posedge clk) begin
		case (current_state)
			D: begin
				out_reg <= 1;
			end
			default: begin
				out_reg <= 0;
			end
		endcase
	end

	// Assign output
	assign out = out_reg;

endmodule
