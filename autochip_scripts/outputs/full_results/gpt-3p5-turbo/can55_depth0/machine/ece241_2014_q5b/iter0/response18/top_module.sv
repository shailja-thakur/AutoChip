module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (x) begin
					state <= B;
				end
			end
			B: begin
				state <= B;
			end
		endcase
	end

	if (state == A && x) begin
		z <= 1;
	end else if (state == B && !x) begin
		z <= 1;
	end else begin
		z <= 0;
	end
end

endmodule
