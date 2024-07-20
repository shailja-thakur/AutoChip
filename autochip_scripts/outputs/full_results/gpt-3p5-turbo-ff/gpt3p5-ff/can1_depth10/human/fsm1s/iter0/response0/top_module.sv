module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b10;
	else begin
		case (state)
			2'b10: begin
				if (in)
					state <= 2'b10;
				else
					state <= 2'b01;
			end

			2'b01: begin
				if (in)
					state <= 2'b01;
				else
					state <= 2'b10;
			end
		endcase
	end
end

assign out = state[0];

endmodule
