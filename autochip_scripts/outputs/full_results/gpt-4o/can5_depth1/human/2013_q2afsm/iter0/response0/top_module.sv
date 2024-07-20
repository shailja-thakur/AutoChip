module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State encoding
	localparam [1:0] S_A = 2'b00, S_B = 2'b01, S_C = 2'b10, S_D = 2'b11;

	// State variables
	reg [1:0] current_state, next_state;

	// State transition always block (combinational)
	always @(*) begin
		case(current_state)
			S_A: begin
				if (r[1] == 1) 
					next_state = S_B;
				else if (r[2] == 1)
					next_state = S_C;
				else if (r[3] == 1)
					next_state = S_D;
				else
					next_state = S_A;
			end
			S_B: begin
				if (r[1] == 1) 
					next_state = S_B;
				else
					next_state = S_A;
			end
			S_C: begin
				if (r[2] == 1)
					next_state = S_C;
				else
					next_state = S_A;
			end
			S_D: begin
				next_state = S_A;
			end
			default: next_state = S_A;
		endcase
	end

	// State flip-flops always block (sequential)
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= S_A;
		else
			current_state <= next_state;
		end
	end

	// Output logic
	always @(current_state or r) begin
		g = 3'b000; // Default value for g
		case (current_state)
			S_A: begin
				// No grant in state A
				g = 3'b000;
			end
			S_B: begin
				// Grant device 1 in state B
				g[1] = 1;
			end
			S_C: begin
				// Grant device 2 in state C
				g[2] = 1;
			end
			S_D: begin
				// Grant device 3 in state D
				g[3] = 1;
			end
		endcase
	end

endmodule
