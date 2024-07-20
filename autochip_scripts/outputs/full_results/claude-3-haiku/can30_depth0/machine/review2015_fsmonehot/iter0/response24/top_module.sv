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
    // Default assignments
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    // Assign outputs based on current state
    if (state[0])  // State S
        S_next = (d == 0);
    else if (state[1])  // State S1
        S1_next = (d == 1);
    else if (state[2])  // State S11
        ; // No output assignments
    else if (state[3])  // State S110
        S_next = (d == 0);
    else if (state[4])  // State B0
        shift_ena = 1;
    else if (state[5])  // State B1
        shift_ena = 1;
    else if (state[6])  // State B2
        shift_ena = 1;
    else if (state[7])  // State B3
        B3_next = 1;
    else if (state[8])  // State Count
        counting = 1;
        Count_next = (done_counting == 0);
    else if (state[9])  // State Wait
        done = 1;
        Wait_next = (ack == 0);
end

endmodule
