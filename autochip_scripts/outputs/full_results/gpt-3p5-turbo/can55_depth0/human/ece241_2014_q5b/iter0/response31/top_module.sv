module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
assign z = state[1];

always@(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b0;
	else begin
		case (state)
			2'b00: begin
				if (x)
					state <= 2'b10;
				else
					state <= 2'b00;
				end
			2'b10: begin
				if (x)
					state <= 2'b01;
				else
					state <= 2'b10;
				end
			2'b01: begin
				if (x)
					state <= 2'b00;
				else
					state <= 2'b01;
				end
		endcase
	end
end

endmodule
