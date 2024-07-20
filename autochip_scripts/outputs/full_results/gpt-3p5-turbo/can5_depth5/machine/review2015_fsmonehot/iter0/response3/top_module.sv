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
 always @(state) begin
    B3_next = (state == B2);
    S_next = ((state == S && !d) || (state == S1 && !d) || (state == S110 && !d) || (state == Wait && ack));
    S1_next = (state == S && d);
    Count_next = (state == B3 || (state == Count && !done_counting));
    Wait_next = (state == Count && done_counting) || (state == Wait && !ack);
 end

 // Output assignments
 always @(state) begin
    done = (state == Wait);
    counting = (state == Count);
    shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
 end
 
endmodule
