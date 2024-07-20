module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

// Define state enum
typedef enum logic [1:0] {
	OFF,
	ON
} state_t;

// Define state register and next_state
reg state_t state_reg, next_state_reg;

// Define output register
reg out_reg;

// Define next_state logic
always_ff @(posedge clk or posedge areset) begin
	if (areset) begin
		state_reg <= OFF;
		out_reg <= 0;
	end else begin
		state_reg <= next_state_reg;
		out_reg <= (state_reg == ON) ? 1 : 0;
	end
end

// Define next_state logic based on inputs
always_comb begin
	case (state_reg)
		OFF: begin
			if (j) begin
				next_state_reg = ON;
			end else begin
				next_state_reg = OFF;
			end
		end
		ON: begin
			if (k) begin
				next_state_reg = OFF;
			end else begin
				next_state_reg = ON;
			end
		end
	endcase
end

// Assign output
assign out = out_reg;

endmodule
