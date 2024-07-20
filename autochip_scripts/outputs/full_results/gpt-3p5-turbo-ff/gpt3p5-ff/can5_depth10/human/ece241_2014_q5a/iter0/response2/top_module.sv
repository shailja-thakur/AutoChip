module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		IDLE,
		CONVERT
	} state_type;

	reg [1:0] state;
	reg [1:0] next_state;

	// Define internal signals
	reg x_reg;
	reg convert_complete;

	// Output assignment
	assign z = ~x_reg + 1;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// State and output assignment logic
	always @(state, x) begin
		case (state)
			IDLE: begin
				if (!areset) begin
					x_reg <= x;
					convert_complete <= 0;
					next_state <= CONVERT;
				end
			end

			CONVERT: begin
				if (!areset) begin
					if (convert_complete == 0) begin
						x_reg <= x;
						convert_complete <= 1;
					end else begin
						next_state <= IDLE;
					end
				end
			end

			default: begin
				x_reg <= x;
				next_state <= IDLE;
			end
		endcase
	end

endmodule
