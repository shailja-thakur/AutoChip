module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output wire B3_next,
    output wire S_next,
    output wire S1_next,
    output wire Count_next,
    output wire Wait_next,
    output wire done,
    output wire counting,
    output wire shift_ena
 );

 // State definitions
 localparam S = 10'b0000000001;
 localparam S1 = 10'b0000000010;
 localparam S11 = 10'b0000000100;
 localparam S110 = 10'b0000001000;
 localparam B0 = 10'b0000010000;
 localparam B1 = 10'b0000100000;
 localparam B2 = 10'b0001000000;
 localparam B3 = 10'b0010000000;
 localparam Count = 10'b0100000000;
 localparam Wait = 10'b1000000000;

 // State logic and next state assignments
 always @(*) begin
    B3_next = (state[5] == 1'b1);
    S_next = ((state[9] == 1'b1 && d == 1'b0) || (state[8] == 1'b1 && d == 1'b0) || (state[7] == 1'b1 && state[4] == 1'b0 && d == 1'b0) || (state[0] == 1'b1 && ack == 1'b1));
    S1_next = (state[9] == 1'b1 && d == 1'b1);
    Count_next = (state[5] == 1'b1 || (state[6] == 1'b1 && done_counting == 1'b0));
    Wait_next = (state[6] == 1'b1 && done_counting == 1'b1) || (state[0] == 1'b1 && ack == 1'b0);
 end

 // Output assignments
 always @(*) begin
    done = (state[0] == 1'b1);
    counting = (state[6] == 1'b1);
    shift_ena = (state[5] == 1'b1 || state[4] == 1'b1 || state[3] == 1'b1 || state[2] == 1'b1);
 end
 
endmodule
