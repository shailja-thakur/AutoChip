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

    wire [9:0] next_state;
    
    assign B3_next = next_state[9];
    assign S_next = next_state[8];
    assign S1_next = next_state[7];
    assign Count_next = next_state[6];
    assign Wait_next = next_state[5];
    
    assign done = (state == 10'b1000000000);
    assign counting = (state >= 10'b1000000000);
    assign shift_ena = (state >= 10'b1010000000);
    
    // State transitions
    always @(*) begin
        case(state)
            10'b0000000001: next_state = d ? 10'b0000000010 : 10'b0000000001;  // S
            10'b0000000010: next_state = d ? 10'b0000000100 : 10'b0000000001;  // S1
            10'b0000000100: next_state = d ? 10'b0000000100 : 10'b0000000110;  // S11
            10'b0000000110: next_state = d ? 10'b0000000100 : 10'b0000000101;  // S110
            10'b0000000101: next_state = d ? 10'b0100000000 : 10'b0000001100;  // B0
            10'b0100000000: next_state = 10'b0010000000;  // B1
            10'b0010000000: next_state = 10'b0001000000;  // B2
            10'b0001000000: next_state = 10'b0000100000;  // B3
            10'b0000100000: next_state = 10'b0000010000;  // Count
            10'b0000010000: next_state = done_counting ? 10'b0000100000 : 10'b0000010001;  // Wait
            10'b0000010001: next_state = ack ? 10'b0000000001 : 10'b0000010001;  // Wait
            default: next_state = 10'b0000000001;
        endcase
    end

endmodule
