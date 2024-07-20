module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [2:0] state, next_state;

	// State encoding
	localparam [2:0] IDLE = 3'b000,
	                 ENA1 = 3'b001,
	                 ENA2 = 3'b010,
	                 ENA3 = 3'b011,
	                 ENA4 = 3'b100;

	// State transition (sequential logic)
	always @(posedge clk) begin
		if (reset) begin
			state <= ENA1;  // Start with ENA1 when reset is active
		end else begin
			state <= next_state;
		end
	end

	// Next state logic (combinational logic)
	always @(*) begin
		case (state)
			IDLE: next_state = IDLE;
			ENA1: next_state = ENA2;
			ENA2: next_state = ENA3;
			ENA3: next_state = ENA4;
			ENA4: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1'b1;
		end else begin
			case (state)
				IDLE: shift_ena <= 1'b0;
				ENA1: shift_ena <= 1'b1;
				ENA2: shift_ena <= 1'b1;
				ENA3: shift_ena <= 1'b1;
				ENA4: shift_ena <= 1'b1;
				default: shift_ena <= 1'b0;
			endcase
		end
	end
	
endmodule
