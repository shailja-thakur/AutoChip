module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// Define state enumeration
	typedef enum {
		A,
		B,
		C,
		D,
		E,
		F
	} state_type;
	
	// Define state and next_state variables
	reg [2:0] state, next_state;
	
	// Initialize state to A
	assign state = A;
	
	// Define state transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Define next_state logic based on current state and input w
	always @(*) begin
		case (state)
			A: if (w) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			
			B: if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			
			C: if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			
			D: if (w) begin
					next_state = A;
				end else begin
					next_state = F;
				end
			
			E: if (w) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			
			F: if (w) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			
			default: next_state = A;
		endcase
	end
	
	// Define output z based on current state
	assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
