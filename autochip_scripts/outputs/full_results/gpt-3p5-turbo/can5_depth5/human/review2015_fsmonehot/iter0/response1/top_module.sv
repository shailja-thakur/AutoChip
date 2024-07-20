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
 
 reg B3_next;
 reg S_next;
 reg S1_next;
 reg Count_next;
 reg Wait_next;
 
 wire done;
 wire counting;
 wire shift_ena;
 
 always @(*)
 begin
    case (state)
        // next-state logic equations
        10'b0000000001: S_next = (d == 0) ? 10'b0000000001 : 10'b0000000010;
        10'b0000000010: S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
        10'b0000000011: S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
        10'b0000000011: S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
        10'b0000000011: S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
        10'b0000000100: S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000011;
        10'b0000000101: B0_next = (d == 0) ? 10'b1000000000 : 10'b0000000111;
        10'b1000000000: B1_next = 10'b0100000000;
        10'b0100000000: B2_next = 10'b0010000000;
        10'b0010000000: B3_next = 10'b0001000000;
        10'b0001000000: Count_next = (done_counting == 0) ? 10'b0001000000 : 10'b0010000000;
        10'b0001000000: Count_next = (done_counting == 0) ? 10'b0001000000 : 10'b1010000000;
        10'b1010000000: Wait_next = (done == 1 && ack == 0) ? 10'b1010000000 : 10'b0000000001;
        10'b1010000000: Wait_next = (done == 1 && ack == 1) ? 10'b1010000000 : 10'b0000000001;
    endcase
 end
 
 // output logic
 assign done = (state == 10'b1010000000);
 assign counting = (state >= 10'b0001000000 && state <= 10'b0010000000);
 assign shift_ena = ((state >= 10'b0001010000 && state <= 10'b0010000000) || state == 10'b0010000000);
 
endmodule
