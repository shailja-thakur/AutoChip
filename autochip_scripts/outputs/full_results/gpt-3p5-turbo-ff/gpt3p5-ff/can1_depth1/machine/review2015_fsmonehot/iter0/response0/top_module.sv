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
 always @(*) begin
    case(state)
        10'b0000000001: next_state = 10'b0000000001;   // state S
        10'b0000000100: next_state = 10'b0000100000;   // state S1
        10'b0000011101: next_state = 10'b0000000000;   // state S11
        10'b0000100110: next_state = 10'b0000000000;   // state S110
        10'b0001000000: next_state = 10'b0000000000;   // state B0
        10'b0010000000: next_state = 10'b0000000000;   // state B1
        10'b0100000000: next_state = 10'b0000000000;   // state B2
        10'b1000000000: next_state = 10'b0000000000;   // state B3
        10'b0000100000: next_state = 10'b0000010000;   // state Count
        10'b0000010011: next_state = 10'b0000000010;   // state Wait
        default: next_state = 0;
    endcase
 end
 
 always @(posedge clk) begin
    state <= next_state;
 end
 
 assign done = (state == 10'b0000010011) ? 1 : 0;
 assign counting = (state == 10'b0000100000) ? 1 : 0;
 assign shift_ena = (state[9] | state[8] | state[7] | state[6]) ? 1 : 0;
 assign B3_next = (state == 10'b0000100000) ? 1 : 0;
 assign S_next = ((state == 10'b0000000001) && (d == 0)) || ((state == 10'b0000000100) && (d == 0)) || ((state == 10'b0000100110) && (d == 0)) || ((state == 10'b0000010011) && (ack == 1)) ? 1 : 0;
 assign S1_next = (state == 10'b0000000001) && (d == 1) ? 1 : 0;
 assign Count_next = (state == 10'b1000000000) || ((state == 10'b0000100000) && (done_counting == 0)) ? 1 : 0;
 assign Wait_next = ((state == 10'b0000100000) && (done_counting == 1)) || ((state == 10'b0000010011) && (ack == 0)) ? 1 : 0;
 
 endmodule
