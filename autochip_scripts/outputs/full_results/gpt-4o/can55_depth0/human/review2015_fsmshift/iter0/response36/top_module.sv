module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] state, next_state;
	reg [2:0] cnt;

	// State encoding
	localparam IDLE = 3'b000;
	localparam SHIFT_1 = 3'b001;
	localparam SHIFT_2 = 3'b010;
	localparam SHIFT_3 = 3'b011;
	localparam SHIFT_4 = 3'b100;
	localparam DONE = 3'b101;

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case(state)
			IDLE: next_state = SHIFT_1;
			SHIFT_1: next_state = SHIFT_2;
			SHIFT_2: next_state = SHIFT_3;
			SHIFT_3: next_state = SHIFT_4;
			SHIFT_4: next_state = DONE;
			DONE: next_state = DONE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic and counter logic
	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1'b1;
			cnt <= 3'd4;
		end else begin
			if (cnt > 0) begin
				cnt <= cnt - 1;
			end else begin
				shift_ena <= 1'b0;
			end
		end
	end

endmodule
