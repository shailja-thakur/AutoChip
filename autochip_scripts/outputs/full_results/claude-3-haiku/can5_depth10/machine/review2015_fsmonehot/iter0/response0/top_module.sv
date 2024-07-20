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

    // Decode the current state
    wire S      = state[0];
    wire S1     = state[1];
    wire S11    = state[2];
    wire S110   = state[3];
    wire B0     = state[4];
    wire B1     = state[5];
    wire B2     = state[6];
    wire B3     = state[7];
    wire Count  = state[8];
    wire Wait   = state[9];

    // Combinational logic for the outputs
    always @(*) begin
        // Set the done signal
        done = Wait;

        // Set the counting signal
        counting = Count;

        // Set the shift_ena signal
        shift_ena = B3 | B2 | B1 | B0;

        // Set the B3_next signal
        B3_next = B2;

        // Set the S_next signal
        S_next = (S && !d) || (S1 && !d) || (S110 && !d) || (Wait && ack);

        // Set the S1_next signal
        S1_next = S && d;

        // Set the Count_next signal
        Count_next = (B3) || (Count && !done_counting);

        // Set the Wait_next signal
        Wait_next = (Count && done_counting) || (Wait && !ack);
    end

endmodule
