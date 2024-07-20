module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

// State definition
typedef enum logic [1:0] {
	IDLE,
	CONVERT
} state_t;

// Define state register and next state logic
reg state_reg;
reg state_next;

// Define intermediate signals
reg x_reg;
reg z_reg;

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state_reg <= IDLE;
		z_reg <= 0;
	end else begin
		state_reg <= state_next;
		if (state_reg == CONVERT) begin
			z_reg <= ~z_reg + 1;
		end else begin
			z_reg <= z_reg;
		end
	end
end

always @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		x_reg <= 0;
	end else begin
		x_reg <= x;
	end
end

always @* begin
	state_next = state_reg;
	case (state_reg)
		IDLE: begin
			if (areset == 1 && x_reg == 1) begin
				state_next = CONVERT;
			end
		end
		CONVERT: begin
			if (x_reg == 1) begin
				state_next = CONVERT;
			end else begin
				state_next = IDLE;
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
