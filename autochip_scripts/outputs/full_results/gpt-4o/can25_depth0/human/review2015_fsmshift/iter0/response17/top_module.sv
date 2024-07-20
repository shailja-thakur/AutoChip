module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state, next_state;
	reg [2:0] count;

	// State parameters
	localparam IDLE = 2'b00;
	localparam SHIFT = 2'b01;
	
	// State transition logic
	always @ (posedge clk) begin
		if (reset) begin
			state <= IDLE;
			count <= 3'b000;
		end else begin
			state <= next_state;
			if(state == SHIFT) count <= count + 1;
		end
	end
	
	// Next state logic
	always @(*) begin
		case(state)
			IDLE: next_state = reset ? SHIFT : IDLE;
			SHIFT: next_state = (count == 3'b100) ? IDLE : SHIFT;
			default: next_state = IDLE;
		endcase
	end
	
	// Output logic
	always @(*) begin
		case(state)
			IDLE: shift_ena = 1'b0;
			SHIFT: shift_ena = 1'b1;
			default: shift_ena = 1'b0;
		endcase
	end
	
endmodule
