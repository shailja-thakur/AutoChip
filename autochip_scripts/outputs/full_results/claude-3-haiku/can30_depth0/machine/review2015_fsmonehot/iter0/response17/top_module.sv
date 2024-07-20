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

always @(*) begin
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    case (1'b1)
        state[0]: // S
            if (d == 0) begin
                S_next = 1;
            end
        state[1]: // S1
            if (d == 1) begin
                S1_next = 1;
            end
        state[2]: // S11
            ;
        state[3]: // S110
            if (d == 0) begin
                S_next = 1;
            end
        state[4]: // B0
            shift_ena = 1;
        state[5]: // B1
            shift_ena = 1;
        state[6]: // B2
            shift_ena = 1;
            B3_next = 1;
        state[7]: // B3
            shift_ena = 1;
        state[8]: // Count
            if (done_counting == 0) begin
                Count_next = 1;
                counting = 1;
            end
        state[9]: // Wait
            if (ack == 1) begin
                Wait_next = 1;
                done = 1;
            end
    endcase
end

endmodule
