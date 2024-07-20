module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] state, next_state;
	
	// State encoding
	localparam IDLE = 3'b000;
	localparam ENA_1 = 3'b001;
	localparam ENA_2 = 3'b010;
	localparam ENA_3 = 3'b011;
	localparam ENA_4 = 3'b100;
	localparam DONE  = 3'b101;

	// State transition
	always @(posedge clk) begin
		if (reset)
			state <= ENA_1;
		else
			state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case (state)
			IDLE: next_state = IDLE;
			ENA_1: next_state = ENA_2;
			ENA_2: next_state = ENA_3;
			ENA_3: next_state = ENA_4;
			ENA_4: next_state = DONE;
			DONE: next_state = DONE;
			default: next_state = IDLE;
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		if (reset)
			shift_ena <= 1;
		else begin
			case (state)
				ENA_1, ENA_2, ENA_3, ENA_4: shift_ena <= 1;
				default: shift_ena <= 0;
			endcase
		end
	end
	
endmodule
