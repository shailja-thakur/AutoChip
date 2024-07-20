module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= B;
		out_reg <= 0;
	end else begin
		case (state)
			B: begin
				if (in == 1'b0)
					state <= A;
				else
					state <= B;
			end

			A: begin
				if (in == 1'b0)
					state <= B;
				else
					state <= A;
			end
		endcase
		if (state == A)
			out_reg <= 1;
		else
			out_reg <= 0;
	end
end

assign out = out_reg;

endmodule
