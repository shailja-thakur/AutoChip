module top_module(
	input clk,
	input reset,
	output shift_ena);

	// Internal signals
	reg [3:0] counter;
	reg shift_ena_reg;

	// FSM states
	parameter INIT = 2'b00;
	parameter WAIT_PATTERN = 2'b01;
	parameter SHIFT_ENABLE = 2'b10;
	parameter SHIFT_DISABLE = 2'b11;

	// FSM current state
	reg [1:0] state;

	// Outputs
	assign shift_ena = shift_ena_reg;

	// Counter for 4 clock cycles
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 0;
		end else begin
			if (state == SHIFT_ENABLE) begin
				if (counter < 3) begin
					counter <= counter + 1;
				end else begin
					counter <= 0;
				end
			end
		end
	end

	// FSM logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= INIT;
		end else begin
			case (state)
				INIT: begin
					if (reset) begin
						state <= INIT;
					end else if (shift_ena_reg == 4'b1010) begin
						state <= WAIT_PATTERN;
					end
				end
				WAIT_PATTERN: begin
					if (reset) begin
						state <= INIT;
					end else if (counter == 3) begin
						state <= SHIFT_ENABLE;
					end else if (shift_ena_reg != 4'b1010) begin
						state <= INIT;
					end
				end
				SHIFT_ENABLE: begin
					if (reset) begin
						state <= INIT;
					end else if (counter == 0) begin
						state <= SHIFT_DISABLE;
					end
				end
				SHIFT_DISABLE: begin
					if (reset) begin
						state <= INIT;
					end else begin
						state <= INIT;
					end
				end
			endcase
		end
	end

	// Enable shift register logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena_reg <= 1'b0;
		end else begin
			case (state)
				INIT: begin
					shift_ena_reg <= 1'b1;
				end
				WAIT_PATTERN: begin
					shift_ena_reg <= 1'b0;
				end
				SHIFT_ENABLE: begin
					shift_ena_reg <= 1'b1;
				end
				SHIFT_DISABLE: begin
					shift_ena_reg <= 1'b0;
				end
			endcase
		end
	end

endmodule
