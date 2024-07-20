module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

	// Define the two states
	typedef enum logic [1:0] {A, B} state_type;

	// Define the state register and initialize it to state A
	reg state_type current_state;
	initial begin
		current_state = A;
	end

	// State transition and output logic
	always @(posedge clk) begin
		if (reset) begin
			current_state <= A;
		end else begin
			case (current_state)
				A: begin
					if (j) begin
						current_state <= B;
					end else begin
						current_state <= A;
					end
				end
				B: begin
					if (k) begin
						current_state <= A;
					end else begin
						current_state <= B;
					end
				end
				default: begin
					current_state <= A;
				end
			endcase
		end
	end

	// Assign output based on current state
	assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
