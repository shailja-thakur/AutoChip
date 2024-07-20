module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [1:0] state, next_state;   // Register for current state and next state

	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	
	// Initialize the current state
	initial begin
		state = A;
	end
	
	// Sequential logic
	always @(posedge clk) begin
		if (!resetn) begin
			state <= A;   // Reset state
		end else begin
			state <= next_state;   // Update state based on next_state
		end
	end
	
	// Combinational logic
	always @(*) begin
		case (state)
			A: begin
				if (!resetn) begin
					next_state = A;   // Stay in state A if reset is asserted
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end else if (x) begin
					next_state = B;   // Transition to state B
					f = 1;   // Turn on f for one clock cycle
					g = 0;   // Turn off g
				end else begin
					next_state = A;   // Stay in state A
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end
			end
			
			B: begin
				if (!resetn) begin
					next_state = A;   // Return to state A if reset is asserted
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end else if (!x) begin
					next_state = C;   // Transition to state C if x produces values 1, 0, 1 in three successive clock cycles
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end else begin
					next_state = B;   // Stay in state B
					f = 1;   // Turn on f for one clock cycle
					g = 0;   // Turn off g
				end
			end
			
			C: begin
				if (!resetn) begin
					next_state = A;   // Return to state A if reset is asserted
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end else if (x) begin
					next_state = C;   // Stay in state C
					f = 0;   // Turn off f
					g = 1;   // Turn on g
				end else if (y && (next_state == C)) begin
					next_state = C;   // Stay in state C
					f = 0;   // Turn off f
					g = 1;   // Turn on g
				end else if (y && (next_state != C)) begin
					next_state = C;   // Stay in state C
					f = 0;   // Turn off f
					g = 1;   // Turn on g
				end else if (!y && (next_state == C)) begin
					next_state = A;   // Transition to state A if y does not become 1 within two clock cycles
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end else begin
					next_state = A;   // Transition to state A
					f = 0;   // Turn off f
					g = 0;   // Turn off g
				end
			end
		endcase
	end
	
endmodule
