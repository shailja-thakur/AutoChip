module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// State Definitions
	typedef enum logic [1:0] {
		IDLE,
		COMPLEMENT
	} state_type;

	// Signal Declarations
	reg areset_reg;
	reg x_reg;
	reg [1:0] state;

	// 2's Complement Function
	assign z = ~x + 1;

	// State Machine Logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			areset_reg <= 1'b1;
			x_reg <= 1'b0;
			state <= IDLE;
		end else begin
			areset_reg <= 1'b0;
			x_reg <= x;
			
			case (state)
				IDLE: begin
					if (!areset_reg)
						state <= COMPLEMENT;
				end
				
				COMPLEMENT: begin
					if (!areset_reg)
						state <= IDLE;
				end
			endcase
		end
	end
endmodule
