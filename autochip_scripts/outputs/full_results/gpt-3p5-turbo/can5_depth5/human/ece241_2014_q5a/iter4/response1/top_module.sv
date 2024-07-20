module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [1:0] state_reg;
reg [1:0] state_next;

// Define intermediate signals
reg x_reg;
reg z_reg;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state_reg <= 2'b0;
		z_reg <= 0;
		x_reg <= 0;
	end else begin
		state_reg <= state_next;
		z_reg <= z_reg;
		x_reg <= x;
	end
end

always @* begin
	state_next = state_reg;
	case (state_reg)
		2'b00: begin // IDLE state
			if (areset == 1 && x_reg == 1) begin
				state_next = 2'b01; // CONVERT state
				z_reg = -x_reg;
			end
		end
		2'b01: begin // CONVERT state
			if (x_reg == 1) begin
				z_reg = ~x_reg + 1;
				state_next = 2'b01; // CONVERT state
			end else begin
				state_next = 2'b00; // IDLE state
			end
		end
	endcase
end

always @(posedge clk) begin
	if (areset == 1) begin
		z <= 0;
	end else begin
		z <= z_reg;
	end
end

endmodule
