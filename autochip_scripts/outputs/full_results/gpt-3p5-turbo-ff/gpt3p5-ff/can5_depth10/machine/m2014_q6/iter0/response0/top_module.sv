module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	// Define the states
	enum logic [2:0] states;
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	// Define the current state and next state variables
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	// State transition logic
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// State and output assignment
	always @(current_state, w) begin
		case (current_state)
			A: begin
				if (w == 1'b0) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			D: begin
				if (w == 1'b1) begin
					next_state = A;
				end else begin
					next_state = F;
				end
			end
			E: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			F: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			default: begin
				next_state = A;
			end
		endcase
	end
	
	// Output assignment
	always @(current_state) begin
		if (current_state == E || current_state == F) begin
			z <= 1'b1;
		end else begin
			z <= 1'b0;
		end
	end
	
endmodule
