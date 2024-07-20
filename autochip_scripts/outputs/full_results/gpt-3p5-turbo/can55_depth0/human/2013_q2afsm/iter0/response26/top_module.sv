module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define signals for next state and current state
	reg [1:0] next_state, current_state;
	
	// Assign initial state
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Define state transitions
	always @(current_state, r) begin
		case (current_state)
			A: begin
				if (r[1] == 1'b1) begin
					next_state <= B;  // Grant to Device 1
				end else if (r[2] == 1'b1) begin
					next_state <= C;  // Grant to Device 2
				end else if (r[3] == 1'b1) begin
					next_state <= D;  // Grant to Device 3
				end else begin
					next_state <= A;  // No grant
				end
			end
			B: begin
				if (r[1] == 1'b1) begin
					next_state <= B;  // Continue grant to Device 1
				end else begin
					next_state <= A;  // Revoke grant
				end
			end
			C: begin
				if (r[2] == 1'b1) begin
					next_state <= C;  // Continue grant to Device 2
				end else begin
					next_state <= A;  // Revoke grant
				end
			end
			D: begin
				if (r[1] == 1'b0 && r[2] == 1'b0 && r[3] == 1'b0) begin
					next_state <= A;  // No grant
				end else begin
					next_state <= D;  // Continue grant to Device 3
				end
			end
		endcase
	end
	
	// Define outputs
	always @(current_state) begin
		case (current_state)
			A: begin
				g[1] <= 1'b0;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end
			B: begin
				g[1] <= 1'b1;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end
			C: begin
				g[1] <= 1'b0;
				g[2] <= 1'b1;
				g[3] <= 1'b0;
			end
			D: begin
				g[1] <= 1'b0;
				g[2] <= 1'b0;
				g[3] <= 1'b1;
			end
		endcase
	end
	
endmodule
