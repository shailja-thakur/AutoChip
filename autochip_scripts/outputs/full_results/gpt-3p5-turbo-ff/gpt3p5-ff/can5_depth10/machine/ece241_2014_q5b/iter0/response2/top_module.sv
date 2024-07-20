module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 0;
parameter B = 1;

reg state;

always @(posedge clk or negedge areset) begin
	if (!areset) begin
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
			B: state <= B;
		endcase
	end
end

assign z = (state == A && x) || (state == B && !x);

endmodule
