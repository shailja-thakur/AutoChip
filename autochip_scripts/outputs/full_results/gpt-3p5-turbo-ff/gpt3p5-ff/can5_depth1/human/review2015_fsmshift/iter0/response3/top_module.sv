module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;

	// FSM states
	localparam IDLE = 2'b00;
	localparam DETECT = 2'b01;
	localparam ENABLE = 2'b10;

	reg [1:0] state, next_state;

	// Output assignment
	assign shift_ena = (state == ENABLE) ? 1'b1 : 1'b0;

	// State and next state assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 4'b0000;
		end else begin
			state <= next_state;
		end
	end

	always @(state) begin
		case (state)
			IDLE: begin
				if (some_condition) begin // Change 'some_condition' to the actual condition you want to check
					next_state <= DETECT;
				end else begin
					next_state <= IDLE;
				end
			end

			DETECT: begin
				next_state <= ENABLE;
			end

			ENABLE: begin
				if (counter == 4'b1111) begin
					next_state <= IDLE;
				end else begin
					next_state <= ENABLE;
				end
			end
		endcase
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 4'b0000;
		end else if (state == ENABLE) begin
			counter <= counter + 1;
		end
	end
endmodule
