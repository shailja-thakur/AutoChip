module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum logic[2:0] {
		A = 3'b000,
		B = 3'b001,
		C = 3'b010,
		D = 3'b011,
		E = 3'b100,
		F = 3'b101,
		G = 3'b110
	} state_t;

	state_t state, next_state;
	reg [1:0] y_counter;

	// State transition
	always_ff @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
			y_counter <= 2'b00;
		end else begin
			state <= next_state;
			if (state == F || state == G) begin
				y_counter <= y_counter + 1;
			end else begin
				y_counter <= 2'b00;
			end
		end
	end

	// Output logic and next state logic
	always_comb begin
		next_state = state;
		f = 1'b0;
		g = 1'b0;

		case (state)
			A: begin
				if (~resetn) begin
					next_state = A;
				end else begin
					next_state = B;
					f = 1'b1;
				end
			end
			B: begin
				next_state = C;
			end
			C: begin
				if (x == 1) begin
					next_state = D;
				end
			end
			D: begin
				if (x == 0) begin
					next_state = E;
				end
			end
			E: begin
				if (x == 1) begin
					next_state = F;
				end
			end
			F: begin
				g = 1'b1;
				if (y_counter == 2'b00 && y == 1) begin
					next_state = G;
				end
				if (y_counter == 2'b01 && y == 0) begin
					next_state = A;
				end
			end
			G: begin
				g = 1'b1;
			end
		endcase
	end
endmodule
