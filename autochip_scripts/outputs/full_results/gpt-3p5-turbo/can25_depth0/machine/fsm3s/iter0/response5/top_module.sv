module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state;
	reg out;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (in) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				B: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				C: begin
					if (in) begin
						state <= D;
					end else begin
						state <= A;
					end
				end
				D: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		if (state == D) begin
			out <= 1'b1;
		end else begin
			out <= 1'b0;
		end
	end

endmodule
