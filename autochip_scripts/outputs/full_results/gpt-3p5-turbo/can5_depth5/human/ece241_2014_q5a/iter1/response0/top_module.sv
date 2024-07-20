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
state_t state_reg;
state_t state_next;

// Define intermediate signals
logic x_reg;
logic z_reg;

always_ff @(posedge clk or negedge areset) begin
	if (areset == 0) begin
		state_reg <= IDLE;
		z_reg <= 0;
	end else begin
		state_reg <= state_next;
		z_reg <= z_reg;
	end
end

always_comb begin
	state_next = state_reg;
	case (state_reg)
		IDLE: begin
			if (areset == 1 && x == 1) begin
				state_next = CONVERT;
				z_reg = -x;
			end
		end
		CONVERT: begin
			if (x == 1) begin
				z_reg = -x;
				state_next = CONVERT;
			end else begin
				state_next = IDLE;
			end
		end
	endcase
end

always_ff @(posedge clk) begin
	if (areset == 1) begin
		z <= 0;
	end else begin
		z <= z_reg;
	end
end

endmodule
