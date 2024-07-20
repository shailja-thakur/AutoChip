module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	typedef enum reg [1:0] {A = 2'b00, B = 2'b01, C = 2'b10} state_t;
	state_t state, next_state;
	reg [1:0] count;
	reg [1:0] w_count;

	// Synchronous state transition
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
		end else begin
			state <= next_state;
			if (state == B)
				w_count <= (count < 2'b11) ? (w_count + w) : 2'b00;
		end
	end

	// State machine next state logic and output logic
	always @(*) begin
		z = 0;
		count = 2'b00;
		next_state = state;
		case (state)
			A: begin
				if (s) next_state = B;
			end
			B: begin
				count = count + 1;
				if (count == 2'b11) begin
					next_state = B;
					if (w_count == 2'b10) z = 1;
				end
			end
			default: next_state = A;
		endcase
	end

endmodule
