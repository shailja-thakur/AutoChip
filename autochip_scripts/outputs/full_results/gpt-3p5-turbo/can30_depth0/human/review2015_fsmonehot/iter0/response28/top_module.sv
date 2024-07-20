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
 
 // define the states
 parameter [9:0] S = 10'b0000000001;
 parameter [9:0] S1 = 10'b0000000010;
 parameter [9:0] S11 = 10'b0000000100;
 parameter [9:0] S110 = 10'b0000001000;
 parameter [9:0] B0 = 10'b0000010000;
 parameter [9:0] B1 = 10'b0000100000;
 parameter [9:0] B2 = 10'b0001000000;
 parameter [9:0] B3 = 10'b0010000000;
 parameter [9:0] Count = 10'b0100000000;
 parameter [9:0] Wait = 10'b1000000000;
 
  // output logic for done, counting, and shift_ena
  assign done = (state == Wait) ? 1 : 0;
  assign counting = (state == Count) ? 1 : 0;
  assign shift_ena = (state >= B0 && state <= B3) ? 1 : 0;

  // next-state logic equations
  assign B3_next = (state == B3) ? 1 : 0;
  assign S_next = (state == S && d == 0) ? 1 : 0;
  assign S1_next = (state == S && d == 1) ? 1 : 0;
  assign Count_next = (state == Count && !done_counting) ? 1 : 0;
  assign Wait_next = (state == Wait && ack == 0) ? 1 : 0;
  
endmodule
