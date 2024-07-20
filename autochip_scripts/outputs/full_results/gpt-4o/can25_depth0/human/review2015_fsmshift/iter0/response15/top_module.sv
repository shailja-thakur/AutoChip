module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	// State definitions
	localparam IDLE   = 2'b00;
	localparam SHIFT1 = 2'b01;
	localparam SHIFT2 = 2'b10;
	localparam SHIFT3 = 2'b11;
	localparam SHIFT4 = 2'b00; // Reusing IDLE state flag after SHIFT4

	reg [1:0] state, next_state;
	reg [3:0] shift_count;

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			shift_count <= 4'b0000;
		end
		else begin
			state <= next_state;
			if (shift_ena) begin
				shift_count <= shift_count + 1;
			end
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (reset)
					next_state = SHIFT1;
				else
					next_state = IDLE;
			end
			SHIFT1: next_state = (shift_count == 4'b0001) ? SHIFT2 : SHIFT1;
			SHIFT2: next_state = (shift_count == 4'b0010) ? SHIFT3 : SHIFT2;
			SHIFT3: next_state = (shift_count == 4'b0011) ? SHIFT4 : SHIFT3;
			SHIFT4: next_state = (shift_count == 4'b0100) ? IDLE : SHIFT4;
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			shift_ena <= 1;
		else if (state == IDLE)
			shift_ena <= 0;
		else
			shift_ena <= 1;
	end
endmodule
