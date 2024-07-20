module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'd2;
	else begin
		case (state)
			2'd0: begin
				if (in == 1'b0)
					state <= 2'd1;
				else if (in == 1'b1)
					state <= 2'd0;
			end

			2'd1: begin
				if (in == 1'b0)
					state <= 2'd0;
				else if (in == 1'b1)
					state <= 2'd1;
			end

			2'd2: begin
				state <= 2'd1;
			end
		endcase
	end
end

always @(state) begin
	case (state)
		2'd0: out = 1'b0;
		2'd1: out = 1'b1;
	endcase
end

endmodule
