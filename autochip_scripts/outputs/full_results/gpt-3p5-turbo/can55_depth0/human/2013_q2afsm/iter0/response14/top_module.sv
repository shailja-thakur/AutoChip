module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	reg [3:1] state, next_state;
	
	// Define the states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	
	initial begin
		state = A;
	end
	
	// State transition logic
	always @(posedge clk) begin
		if (!resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(state, r) begin
		case (state)
			A: begin
				if (r[1]) begin
					next_state = B;
				end else if (r[2]) begin
					next_state = C;
				end else if (r[3]) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (r[1]) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			C: begin
				if (r[2]) begin
					next_state = C;
				end else begin
					next_state = A;
				end
			end
			D: begin
				next_state = A;
			end
			default: next_state = A;
		endcase
	end
	
	// Output control logic
	always @(state) begin
		case (state)
			A: begin
				g[1] = (r[1] && !r[2] && !r[3]);
				g[2] = 0;
				g[3] = 0;
			end
			B: begin
				g[1] = (r[1] && g[1]);
				g[2] = 0;
				g[3] = 0;
			end
			C: begin
				g[1] = (r[1]);
				g[2] = (r[2] && g[2]);
				g[3] = 0;
			end
			D: begin
				g[1] = (r[1]);
				g[2] = (r[2]);
				g[3] = (r[3]);
			end
			default: begin
				g[1] = 0;
				g[2] = 0;
				g[3] = 0;
			end
		endcase
	end
	
endmodule
