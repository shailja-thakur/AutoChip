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

always @* begin
    case(state)
        10'b0000000001: B3_next = 1'b1;    // B2 state
        10'b1000000001: S_next = 1'b1;     // S state and d is 0
        10'b0100000001: S_next = 1'b1;     // S1 state and d is 0
        10'b0010000001: S_next = 1'b1;     // S110 state and d is 0
        10'b1100000001: S_next = 1'b1;     // Wait state and ack is 1
        default: B3_next = 1'b0;
                 S_next = 1'b0;
    endcase
    if(state == 10'b0000000001 && d == 1'b1)   // S state and d is 1
        S1_next = 1'b1;
    else
        S1_next = 1'b0;
    
    if(state == 10'b1000000001)   // B3 state
        Count_next = 1'b1;
    else if(state == 10'b0010000001 && done_counting == 1'b0)   // Count state and done_counting is 0
        Count_next = 1'b1;
    else
        Count_next = 1'b0;
    
    if(state == 10'b1100000001 && done_counting == 1'b1)   // Wait state and done_counting is 1
        Wait_next = 1'b1;
    else if(state == 10'b1100000001 && ack == 1'b0)   // Wait state and ack is 0
        Wait_next = 1'b1;
    else
        Wait_next = 1'b0;
end

assign done = (state == 10'b1100000001) ? 1'b1 : 1'b0;   // done signal is 1 in the Wait state
assign counting = (state == 10'b0010000001) ? 1'b1 : 1'b0;   // counting signal is 1 in the Count state

assign shift_ena = (state == 10'b1000000001 || state == 10'b0100000001 || state == 10'b0000000001 || state == 10'b0010000001) ? 1'b1 : 1'b0;   // shift_ena is 1 if any of the B0, B1, B2, B3 states is active

endmodule
