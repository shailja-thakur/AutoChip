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
        // B3, B2, B1 and B0 are the active states
        // shift_ena should be 1
        {B3, B2, B1, B0} : shift_ena = 1;
        default : shift_ena = 0;
    endcase
end

always @* begin
    case(state)
        // S and d is 0, or S1 and d is 0, or S110 and d is 0, or Wait and ack is 1
        // S_next should be 1
        {S, !d} : S_next = 1;
        {S1, !d} : S_next = 1;
        {S110, !d} : S_next = 1;
        {Wait, ack} : S_next = 1;
        default : S_next = 0;
    endcase
end

always @* begin
    case(state)
        // S and d is 1
        // S1_next should be 1
        {S, d} : S1_next = 1;
        default : S1_next = 0;
    endcase
end

always @* begin
    case(state)
        // B3 is active, or Count and done_counting is 0
        // Count_next should be 1
        {B3} : Count_next = 1;
        {Count, !done_counting} : Count_next = 1;
        default : Count_next = 0;
    endcase
end

always @* begin
    case(state)
        // Count and done_counting is 1, or Wait and ack is 0
        // Wait_next should be 1
        {Count, done_counting} : Wait_next = 1;
        {Wait, !ack} : Wait_next = 1;
        default : Wait_next = 0;
    endcase
end

always @* begin
    // B2 is active
    // B3_next should be 1
    B3_next = (state == B2) ? 1 : 0;
end

assign done = (state == Wait) ? 1 : 0;    // done signal is 1 in the state Wait

assign counting = (state == Count) ? 1 : 0;    // counting signal is 1 in the state Count

endmodule
