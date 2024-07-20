module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define state encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t state, next_state;
	reg [2:0] cnt; // Counter for 3 clock cycles
	reg [1:0] w_count; // Counter for w=1 count in 3 clock cycles

	// State transition
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			cnt <= 3'b0;
			w_count <= 2'b0;
			z <= 0;
		end else begin
			state <= next_state;
			cnt <= (next_state == C) ? 3'b0 : (cnt + 1);
			w_count <= (next_state == C) ? 2'b0 : (w ? (w_count + 1) : w_count);
			z <= (next_state == C && w_count == 2'b10) ? 1 : 0;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (s == 1'b1) 
					next_state = B;
				else 
					next_state = A;
			end
			B: begin
				if (cnt == 3'd3) 
					next_state = C;
				else 
					next_state = B;
			end
			C: begin
				next_state = B;
			end
			default: 
				next_state = A;
		endcase
	end

endmodule
