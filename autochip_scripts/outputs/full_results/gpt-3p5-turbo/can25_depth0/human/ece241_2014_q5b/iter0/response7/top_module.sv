module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declaration
	reg [1:0] state;

	// State assignments
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
			z <= 0;
		end else begin
			case (state)
				A: begin
					if (x) begin
						state <= B;
						z <= 1;
					end else begin
						state <= A;
						z <= 0;
					end
				end
				B: begin
					if (x) begin
						state <= B;
						z <= 0;
					end else begin
						state <= B;
						z <= 1;
					end
				end
			endcase
		end
	end
endmodule
