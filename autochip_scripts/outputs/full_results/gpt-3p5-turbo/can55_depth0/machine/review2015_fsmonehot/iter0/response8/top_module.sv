module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

	reg S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
	reg [9:0] next_state;
	reg next_B3_next, next_S_next, next_S1_next, next_Count_next, next_Wait_next;

	parameter S_value = 10'b0000000001;
	parameter S1_value = 10'b0000000010;
	parameter S11_value = 10'b0000000100;
	parameter S110_value = 10'b0000001000;
	parameter B0_value = 10'b0000010000;
	parameter B1_value = 10'b0000100000;
	parameter B2_value = 10'b0001000000;
	parameter B3_value = 10'b0010000000;
	parameter Count_value = 10'b0100000000;
	parameter Wait_value = 10'b1000000000;

	always @(state) begin
		S = (state == S_value);
		S1 = (state == S1_value);
		S11 = (state == S11_value);
		S110 = (state == S110_value);
		B0 = (state == B0_value);
		B1 = (state == B1_value);
		B2 = (state == B2_value);
		B3 = (state == B3_value);
		Count = (state == Count_value);
		Wait = (state == Wait_value);
	end

	always @(posedge clk) begin
		if (reset) begin
			next_state <= S_value;
			next_B3_next <= 0;
			next_S_next <= 0;
			next_S1_next <= 0;
			next_Count_next <= 0;
			next_Wait_next <= 0;
		end else begin
			next_state <= state;

			// Calculate next values for output signals
			next_B3_next <= B2;
			next_S_next <= ((S & ~d) || (S1 & ~d) || (S110 & ~d) || (Wait & ack));
			next_S1_next <= (S & d);
			next_Count_next <= (B3 || (Count & ~done_counting));
			next_Wait_next <= ((Count & done_counting) || (Wait & ~ack));
		end
	end

	always @(next_state) begin
		case (next_state)
			S_value: done <= 0;
			Count_value, Wait_value: done <= 1;
			default: done <= 0;
		endcase

		case (next_state)
			Count_value: counting <= 1;
			default: counting <= 0;
		endcase

		shift_ena <= (B3 || B2 || B1 || B0);
	end

	always @(posedge clk) begin
		state <= next_state;
		B3_next <= next_B3_next;
		S_next <= next_S_next;
		S1_next <= next_S1_next;
		Count_next <= next_Count_next;
		Wait_next <= next_Wait_next;
	end

endmodule
