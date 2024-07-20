module top_module (
	input clk,
	input areset,
	input x,
	output z
);

// State definition
typedef enum logic [1:0] {
	IDLE,
	CONVERT
} state_t;

// Define state register and next state logic
state_t state_reg;
state_t state_next;

// Define intermediate signals
reg x_reg;
reg z_reg;
wire z_next;

always_ff @(posedge clk, negedge areset) begin
	if (areset == 0) begin
		state_reg <= IDLE;
		z_reg <= 0;
	end else begin
		state_reg <= state_next;
		z_reg <= z_next;
	end
end

always_comb begin
	state_next = state_reg;
	z_next = z_reg;
	case (state_reg)
		IDLE: begin
			if (areset == 1 && x == 1) begin
				state_next = CONVERT;
				z_next = -x_reg;
			end
		end
		CONVERT: begin
			if (x == 1) begin
				z_next = -x_reg;
			end else begin
				state_next = IDLE;
			end
		end
	endcase
end

always_ff @(posedge clk) begin
	x_reg <= x;
end

assign z = z_reg;

endmodule
