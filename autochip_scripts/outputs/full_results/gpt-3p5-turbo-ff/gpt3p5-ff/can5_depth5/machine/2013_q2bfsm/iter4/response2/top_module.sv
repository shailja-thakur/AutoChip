module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states
	reg [3:0] state, next_state;

	// Assignments
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= 0;
		end else begin
			state <= next_state;
		end
	end

	// Combinational logic
	always_comb begin
		case (state)
			0: begin  // A
				if (x) begin
					next_state = 1;  // B
				end else begin
					next_state = 2;  // S0
				end
			end
			1: begin  // B
				next_state = 2;  // S0
			end
			2: begin  // S0
				if (x) begin
					next_state = 3;  // S1
				end else begin
					next_state = 2;  // S0
				end
			end
			3: begin  // S1
				if (x) begin
					next_state = 3;  // S1
				end else begin
					next_state = 4;  // S10
				end
			end
			4: begin  // S10
				if (x) begin
					next_state = 5;  // G1
				end else begin
					next_state = 2;  // S0
				end
			end
			5: begin  // G1
				if (y) begin
					next_state = 8;  // P1
				end else begin
					next_state = 6;  // G2
				end
			end
			6: begin  // G2
				if (y) begin
					next_state = 8;  // P1
				end else begin
					next_state = 7;  // P0
				end
			end
			7, 8: begin  // P0, P1
				next_state = state;
			end
		endcase
	end

	// Assign outputs
	always @(state, next_state) begin
		f = (state == 1);  // B
		g = ((state == 5) || (state == 6) || (state == 8));  // G1, G2, P1
	end
	
endmodule
