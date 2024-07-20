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

    // Next-state logic
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1)  // One-hot case statement
            state[0]: S_next = ~d;
            state[1]: begin
                S1_next = d;
                S_next = ~d;
            end
            state[2]: S1_next = ~d;
            state[8]: begin
                B3_next = d;
                Count_next = done_counting;
            end
            state[9]: Wait_next = ~ack;
        endcase
    end

    // Output logic
    always @(*) begin
        done = state[9];
        counting = state[8];
        shift_ena = state[4] | state[5] | state[6] | state[7];
    end

endmodule
