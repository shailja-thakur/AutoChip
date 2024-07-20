module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State declaration
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	state_t current_state, next_state;

	reg [1:0] count;

	// State transition logic
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= A;
			count <= 2'b00;
			z <= 1'b0;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic and output logic
	always @ (*) begin
		z = 1'b0; // Default output
		next_state = current_state; // Default state

		case(current_state)
			A: begin
				if (s == 1'b1)
					next_state = B;
			end

			B: begin
				if (count == 2'b11) begin
					next_state = C;
				end else begin
					next_state = B;
				end
			end

			C: begin
				if (count == 2'b10) begin
					z = 1'b1;
				end
				next_state = D;
			end

			D: begin
				count = 2'b00;
				next_state = B;
			end
		endcase
	end

	// Counting logic for state B
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			count <= 2'b00;
		end else if (current_state == B) begin
			if (w == 1'b1)
				count <= count + 1;
			if (count == 2'b11)
				count <= 2'b00;
		end
	end

endmodule
