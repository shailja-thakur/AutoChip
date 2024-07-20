module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg [1:0] state;

	// State definitions
	parameter A = 2'b00;
	parameter B = 2'b01;

	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (x) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				B: begin
					if (x) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
			endcase
		end
	end

	// Output logic
	always @(posedge clk) begin
		case (state)
			A: begin
				z <= 1'b0;
			end
			B: begin
				z <= 1'b1;
			end
		endcase
	end

endmodule
