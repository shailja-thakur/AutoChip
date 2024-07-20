module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [1:0] state_reg, state_next;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state_reg <= 2'b00;
		z <= 1'b0;
	end else begin
		state_reg <= state_next;
	end
end

always @* begin
	state_next = state_reg;
	case (state_reg)
		2'b00: begin
			if (areset == 1 && x == 1) begin
				state_next = 2'b01;
				z <= ~x + 1;
			end
		end
		2'b01: begin
			if (x == 1) begin
				state_next = 2'b01;
				z <= ~z + 1;
			end else begin
				state_next = 2'b00;
			end
		end
	endcase
end

endmodule
