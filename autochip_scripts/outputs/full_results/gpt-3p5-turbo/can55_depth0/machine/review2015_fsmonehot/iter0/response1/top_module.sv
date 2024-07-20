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

    reg B3_active;
    reg S_active;
    reg S1_active;
    reg B3_next_active;
    reg S_next_active;
    reg S1_next_active;
    reg Count_next_active;
    reg Wait_next_active;

    always @(*) begin
        B3_active = (state[3] == 1'b1);
        S_active = (state[0] == 1'b1) && (d == 1'b0);
        S1_active = (state[1] == 1'b1) && (d == 1'b0);
        B3_next_active = (state[2] == 1'b1);
        S_next_active = (S_active || S1_active || (state[6] == 1'b1 && d == 1'b0) || (state[9] == 1'b1 && ack == 1'b1));
        S1_next_active = S_active && (d == 1'b1);
        Count_next_active = (B3_active || (state[5] == 1'b1 && done_counting == 1'b0));
        Wait_next_active = ((state[5] == 1'b1 && done_counting == 1'b1) || (state[9] == 1'b1 && ack == 1'b0));

        B3_next = B3_next_active;
        S_next = S_next_active;
        S1_next = S1_next_active;
        Count_next = Count_next_active;
        Wait_next = Wait_next_active;
        done = (state[9] == 1'b1 && ack == 1'b0);
        counting = (state[8] == 1'b1 || Count_next_active);
        shift_ena = (B3_active || (state[7] == 1'b1) || (state[6] == 1'b1) || (state[5] == 1'b1));
    end
endmodule
