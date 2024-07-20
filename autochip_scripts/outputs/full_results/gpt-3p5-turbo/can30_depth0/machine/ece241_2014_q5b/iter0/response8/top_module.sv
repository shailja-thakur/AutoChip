module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;
reg z;

always @(posedge clk) begin
	if (areset == 1'b1) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (x == 1'b1) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				state <= B;
			end
		endcase
	end
end

always @(state, x) begin
	if ((state == A && x == 1'b1) || (state == B && x == 1'b0)) begin
		z <= 1'b1;
	end else begin
		z <= 1'b0;
	end
end

endmodule
