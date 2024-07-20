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
 
	reg [9:0] next_state;

	always @(state) begin
		case (state)
			S: begin
				if (d == 0)
					next_state = S_next ? S1 : S;
				else
					next_state = S;
			end
			S1: begin
				if (d == 1)
					next_state = S1_next ? S : S1;
				else
					next_state = S1;
			end
			S11: begin
				next_state = S11;
			end
			S110: begin
				next_state = S_next ? S : S110;
			end
			B0: begin
				next_state = B0;
			end
			B1: begin
				next_state = B1;
			end
			B2: begin
				next_state = B2;
			end
			B3: begin
				next_state = B3_next ? B2 : B3;
			end
			Count: begin
				if (done_counting == 0)
					next_state = B3;
				else
					next_state = Count_next ? Wait : Count;
			end
			Wait: begin
				if (ack == 1)
					next_state = Count;
				else
					next_state = Wait_next ? Wait : Count;
			end
			default: next_state = state;
		endcase
	end

	assign done = (state == Wait);
	assign counting = (state == Count);
	assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
	
	always @(posedge clk) begin
		state <= next_state;
	end

endmodule
