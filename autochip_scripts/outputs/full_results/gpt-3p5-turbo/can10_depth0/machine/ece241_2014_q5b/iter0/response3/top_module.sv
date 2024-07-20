module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 0;
parameter B = 1;

reg state;
assign z = (state == A && x == 1) || (state == B && x == 0);

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (x == 1) begin
					state <= B;
				end
			end
			B: begin
				state <= B;
			end
		endcase
	end
end

endmodule
