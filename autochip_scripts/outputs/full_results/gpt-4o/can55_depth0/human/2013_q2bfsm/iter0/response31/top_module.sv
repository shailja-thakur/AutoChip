module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum reg [2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101
	} state_t;

	state_t current_state, next_state;
	reg [1:0] y_counter;  // Counter to monitor y within 2 clock cycles
	
	// State transition
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end

	always @(*) begin
		// Default values
		next_state = current_state;
		f = 0;
		g = 0;
		
		case (current_state)
			A: begin
				// Stay in state A as long as reset is asserted
				if (resetn)
					next_state = B;
			end

			B: begin
				// Set output f to 1 for one clock cycle
				f = 1;
				next_state = C;
			end

			C: begin
				// Monitor x input for sequence 1, 0, 1
				if (x == 1'b1)
					next_state = D;
			end

			D: begin
				if (x == 1'b0)
					next_state = E;
				else
					next_state = C;
			end
			
			E: begin
				if (x == 1'b1) begin
					next_state = F;
					g = 1;
					y_counter = 2;
				end else
					next_state = C;
			end
			
			F: begin
				// g = 1; check y for up to 2 cycles
				g = 1;
				if (y == 1'b1) begin
					// Maintain g = 1 permanently until reset
					next_state = F;
				end else if (y_counter == 0) begin
					// Set g = 0 permanently until reset
					next_state = C;
				end
				y_counter = y_counter - 1;
			end
			
			default: next_state = A;
		endcase
	end
endmodule
