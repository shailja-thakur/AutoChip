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
 
 	// Define the states
 	parameter S = 0;
 	parameter S1 = 1;
 	parameter S11 = 2;
 	parameter S110 = 3;
 	parameter B0 = 4;
 	parameter B1 = 5;
 	parameter B2 = 6;
 	parameter B3 = 7;
 	parameter Count = 8;
 	parameter Wait = 9;
 
 	reg [9:0] next_state;
 	reg [9:0] current_state;
 
 	// Assigning state inputs to current_state
 	always @(state)
 	begin
 		current_state <= state;
 	end
 
 	// Assigning next_state based on current_state
 	always @(*)
 	begin
 		case(current_state)
 			S: 
 			begin
 				if (d == 0)
 					next_state = S_next ? S1 : S;
 				else
 					next_state = S;
 			end
 			S1:
 			begin
 				if (d == 1)
 					next_state = S1_next ? S : S1;
 				else
 					next_state = S1;
 			end
 			S11:
 			begin
 				next_state = S11;
 			end
 			S110:
 			begin
 				next_state = S110;
 			end
 			B0:
 			begin
 				next_state = B0;
 			end
 			B1:
 			begin
 				next_state = B1;
 			end
 			B2:
 			begin
 				if (current_state == B2 && d == 1)
 					next_state = B3_next ? B2 : B2;
 				else
 					next_state = B2;
 			end
 			B3:
 			begin
 				next_state = B3;
 			end
 			Count:
 			begin
 				if (current_state == B3)
 					next_state = Count_next ? Count : B3;
 				else
 					next_state = Count;
 			end
 			Wait:
 			begin
 				if (current_state == Count && done_counting == 0)
 					next_state = Wait_next ? Count : Wait;
 				else
 					next_state = Wait;
 			end
 		endcase
 	end
 
 	// Assigning the outputs based on next_state
 	always @(*)
 	begin
 		B3_next = (current_state == B2) ? 1'b1 : 1'b0;
 
 		S_next = ((current_state == S && d == 0) || (current_state == S1 && d == 0) || (current_state == S110 && d == 0) || (current_state == Wait && ack == 1)) ? 1'b1 : 1'b0;
 
 		S1_next = (current_state == S && d == 1) ? 1'b1 : 1'b0;
 
 		Count_next = ((current_state == B3) || (current_state == Count && done_counting == 0)) ? 1'b1 : 1'b0;
 
 		Wait_next = ((current_state == Count && done_counting == 1) || (current_state == Wait && ack == 0)) ? 1'b1 : 1'b0;
 
 		done = (current_state == Wait) ? 1'b1 : 1'b0;
 
 		counting = (current_state == Count) ? 1'b1 : 1'b0;
 
 		shift_ena = ((current_state == B0) || (current_state == B1) || (current_state == B2) || (current_state == B3)) ? 1'b1 : 1'b0;
 	end
 
 endmodule
