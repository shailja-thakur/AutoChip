module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State declarations
	typedef enum logic [1:0] {
		A    = 2'b00,
		B    = 2'b01,
		B1   = 2'b10,
		B2   = 2'b11
	} state_t;
	
	state_t state, next_state;
	reg [1:0] w_count;  // Counter for the 'w' input in state B
	
	// State transition logic
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			z <= 1'b0;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic and output logic
	always_comb begin
		next_state = state;
		z = 1'b0; // default value of z
		
		case (state)
			A: begin
				if (s) begin
					next_state = B;
					w_count = 2'b00;
				end
			end
			
			B: begin
				if (w) begin
					w_count = w_count + 2'b01;
				end
				
				next_state = B1;
			end
			
			B1: begin
				if (w) begin
					w_count = w_count + 2'b01;
				end
				
				next_state = B2;
			end
			
			B2: begin
				if (w) begin
					w_count = w_count + 2'b01;
				end
				
				if (w_count == 2'b10) begin
					z = 1'b1;
				end
				next_state = B;
			end
			
			default: begin
				next_state = A;
			end
		endcase
	end

endmodule
