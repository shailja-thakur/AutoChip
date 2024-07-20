module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 0;
		out <= 0;
	end else begin
		case (state)
			2'd0: begin
				if (in)
					state <= 2'd1;
				else
					state <= 2'd0;
			end
			2'd1: begin
				if (in)
					state <= 2'd1;
				else
					state <= 2'd2;
			end
			2'd2: begin
				if (in)
					state <= 2'd3;
				else
					state <= 2'd0;
			end
			2'd3: begin
				if (in)
					state <= 2'd1;
				else
					state <= 2'd2;
			end
		endcase
	end
end

assign out = (state == 2'd3) ? 1'b1 : 1'b0;

endmodule
