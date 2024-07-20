module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state, next_state;

	parameter B = 2'b00;
	parameter A = 2'b01;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	always @(state, in) begin
		case (state)
			B: begin
				if (in) begin
					next_state = B;
					out = 1'b1;
				end else begin
					next_state = A;
					out = 1'b1;
				end
			end
			A: begin
				if (in) begin
					next_state = A;
					out = 1'b0;
				end else begin
					next_state = B;
					out = 1'b0;
				end
			end
		endcase
	end

endmodule
