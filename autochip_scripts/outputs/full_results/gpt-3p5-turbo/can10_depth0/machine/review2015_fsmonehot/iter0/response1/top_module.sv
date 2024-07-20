module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

	reg B3_next_reg, S_next_reg, S1_next_reg, Count_next_reg, Wait_next_reg;

	// Combinnational logic for B3_next
	assign B3_next = B3_next_reg;
	always @(*) begin
		case(state)
			B2: B3_next_reg = 1;
			default: B3_next_reg = 0;
		endcase
	end

	// Combinnational logic for S_next
	assign S_next = S_next_reg;
	always @(*) begin
		case(state)
			S: S_next_reg = (d == 0);
			S1: S_next_reg = (d == 0);
			S110: S_next_reg = (d == 0);
			Wait: S_next_reg = ack;
			default: S_next_reg = 0;
		endcase
	end

	// Combinnational logic for S1_next
	assign S1_next = S1_next_reg;
	always @(*) begin
		case(state)
			S: S1_next_reg = (d == 1);
			default: S1_next_reg = 0;
		endcase
	end

	// Combinnational logic for Count_next
	assign Count_next = Count_next_reg;
	always @(*) begin
		case(state)
			B3: Count_next_reg = 1;
			Count: Count_next_reg = (done_counting == 0);
			default: Count_next_reg = 0;
		endcase
	end

	// Combinnational logic for Wait_next
	assign Wait_next = Wait_next_reg;
	always @(*) begin
		case(state)
			Count: Wait_next_reg = (done_counting == 1);
			Wait: Wait_next_reg = !ack;
			default: Wait_next_reg = 0;
		endcase
	end

	// Combinnational logic for done
	assign done = (state == Wait);

	// Combinnational logic for counting
	assign counting = (state == Count);

	// Combinnational logic for shift_ena
	assign shift_ena = (state == B3) || (state == B2) || (state == B1) || (state == B0);
	
endmodule
