module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Define state encoding
	typedef enum reg [1:0] {A = 2'b00, B = 2'b01} state_t;
	state_t state, next_state;

	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			A: begin
				out = 1'b0;
				if (j == 1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				out = 1'b1;
				if (k == 1) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			default: begin
				next_state = A;
				out = 1'b0;
			end
		endcase
	end
endmodule
