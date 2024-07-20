module top_module (
	input in,
	input [9:0] state,
	output [9:0] next_state,
	output out1,
	output out2);

	/* Define the state encoding */
	parameter S0 = 10'b0000000001;
	parameter S1 = 10'b0000000010;
	parameter S2 = 10'b0000000100;
	parameter S3 = 10'b0000001000;
	parameter S4 = 10'b0000010000;
	parameter S5 = 10'b0000100000;
	parameter S6 = 10'b0001000000;
	parameter S7 = 10'b0010000000;
	parameter S8 = 10'b0100000000;
	parameter S9 = 10'b1000000000;

	/* Define the output values */
	parameter OUT_ZERO = 1'b0;
	parameter OUT_ONE = 1'b1;

	/* Define next state and output value equations */
	always @* begin
		case(state)
			S0: begin
				if(in)
					{next_state, out1, out2} = {S1, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S1: begin
				if(in)
					{next_state, out1, out2} = {S2, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S2: begin
				if(in)
					{next_state, out1, out2} = {S3, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S3: begin
				if(in)
					{next_state, out1, out2} = {S4, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S4: begin
				if(in)
					{next_state, out1, out2} = {S5, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S5: begin
				if(in)
					{next_state, out1, out2} = {S6, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S8, OUT_ZERO, OUT_ZERO};
			end
			S6: begin
				if(in)
					{next_state, out1, out2} = {S7, OUT_ZERO, OUT_ZERO};
				else
					{next_state, out1, out2} = {S9, OUT_ZERO, OUT_ZERO};
			end
			S7: begin
				if(in)
					{next_state, out1, out2} = {S7, OUT_ZERO, OUT_ONE};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S8: begin
				if(in)
					{next_state, out1, out2} = {S1, OUT_ONE, OUT_ZERO};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
			S9: begin
				if(in)
					{next_state, out1, out2} = {S1, OUT_ONE, OUT_ONE};
				else
					{next_state, out1, out2} = {S0, OUT_ZERO, OUT_ZERO};
			end
		endcase
	end
endmodule
