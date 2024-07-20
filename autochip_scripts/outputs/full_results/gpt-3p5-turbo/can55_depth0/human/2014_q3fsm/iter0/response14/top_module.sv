module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

parameter A = 1'b0;
parameter B = 1'b1;

reg [1:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= A;
		z <= 0;
	end else begin
		case (state)
			A: begin
				if (s) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				state <= A; // Default transition
				if (w == 2'b11) begin
					z <= 1;
				end else begin
					z <= 0;
				end
			end
		endcase
	end
end

endmodule
