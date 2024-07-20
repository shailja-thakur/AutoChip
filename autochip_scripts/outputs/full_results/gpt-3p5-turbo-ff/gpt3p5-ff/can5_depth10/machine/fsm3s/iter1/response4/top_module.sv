module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		case (state)
			A: begin
				if (in) begin
					next_state <= B;  // Changed "=" to "<="
				end else begin
					next_state <= A;  // Changed "=" to "<="
				end
			end
			B: begin
				if (in) begin
					next_state <= B;  // Changed "=" to "<="
				end else begin
					next_state <= C;  // Changed "=" to "<="
				end
			end
			C: begin
				if (in) begin
					next_state <= D;  // Changed "=" to "<="
				end else begin
					next_state <= A;  // Changed "=" to "<="
				end
			end
			D: begin
				if (in) begin
					next_state <= B;  // Changed "=" to "<="
				end else begin
					next_state <= C;  // Changed "=" to "<="
				end
			end
			default: next_state <= A;  // Changed "=" to "<="
		endcase
	end

	assign out = (state == D);

endmodule
