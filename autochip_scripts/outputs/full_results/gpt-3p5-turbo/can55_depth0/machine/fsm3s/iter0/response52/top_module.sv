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

	// Declare state and next_state variables
	reg [1:0] state, next_state;

	// Initialize state variable with initial state value
	assign state = A;

	// Define state transitions
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Define next_state logic
	always @(*) begin
		case (state)
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
			
			default: next_state = A; // Default case for safety
		endcase
	end
	
	// Define output logic
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
