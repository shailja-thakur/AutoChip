module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;

	// Define state register
	reg state_type current_state, next_state;

	// Define output register
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
	always @(current_state) begin
		case (current_state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
				out_reg = 0;
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				out_reg = 0;
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
				out_reg = 0;
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				out_reg = 1;
			end
			default: begin
				next_state = A;
				out_reg = 0;
			end
		endcase
	end
	
	// Assign outputs
	assign out = out_reg;
	
endmodule
