module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	typedef enum reg [1:0] {A, B, C} state_t;
	state_t state, next_state;
	reg [1:0] counter;

	always @(posedge clk) begin
		if (reset) begin
			state <= A;
			z <= 0;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			A: begin
				z <= 0;
				if (s) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (counter == 2) begin
					z <= 1;
					next_state = C;
				end else begin
					z <= 0;
					next_state = B;
				end
			end
			C: begin
				if (s == 0) begin
					next_state = A;
				end else begin
					next_state = B;
				end
				counter = 0;
			end
			default: begin
				next_state = A;
			end
		endcase
	end

	always @(posedge clk) begin
		if (state == B) begin
			if (w) begin
				counter <= counter + 1;
			end
		end else begin
			counter <= 0;
		end
	end

endmodule
