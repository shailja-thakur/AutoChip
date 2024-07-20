module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define the states
	typedef enum {A, B, C, D, E, F, G, H} state_t;
	state_t current_state, next_state;
	
	reg [1:0] y_count; // Counter to monitor y input for conditions

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	always @(*) begin
		next_state = current_state; // Default to staying in current state
		f = 0;                     // Default outputs
		case (current_state)
			A: begin
				if (resetn == 1) begin
					next_state = B;
					f = 1; // Set f to 1 for one clock cycle
				end
			end			
			B: begin
				next_state = C;
			end			
			C: begin
				if (x) next_state = D;
			end			
			D: begin
				if (!x) next_state = E;
			end			
			E: begin
				if (x) begin
					next_state = F;
				end else begin
					next_state = C;
				end
			end			
			F: begin
				g = 1;
				next_state = G;
			end			
			G: begin
				if (y) begin
					next_state = H;
				end else if (y_count == 2) begin
					g = 0;
					next_state = H;
				end else begin
					next_state = G;
				end
			end
			H: begin
				g = (y || g) ? 1 : 0;  // Maintain g based on conditions
			end			
			default: begin
				next_state = A;
			end
		endcase
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			y_count <= 0;
		end else if (current_state == G && !y) begin
			y_count <= y_count + 1;
		end else if (current_state != G) begin
			y_count <= 0;
		end
	end

endmodule
