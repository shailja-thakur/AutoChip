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

    assign shift_ena = (state[3] | state[4] | state[5] | state[6]);

    assign B3_next = state[5];

    // Output assignments for state transitions
    always @(state or d or ack or done_counting) begin
        case (state)
            S:
                S_next = (d == 0);
                S1_next = (d == 1);
                Count_next = 0;
                Wait_next = ack;
            S1:
                S_next = (d == 0);
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            S11:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            S110:
                S_next = (d == 0);
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            B0:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            B1:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            B2:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            B3:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = ack;
            Count:
                S_next = 0;
                S1_next = 0;
                Count_next = (state[6] | done_counting);
                Wait_next = ack;
            Wait:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = (~ack);
            default:
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
        endcase
    end

    // Output assignments for done and counting signals
    always @(state) begin
        case (state)
            S:
                done = 0;
                counting = 0;
            S1:
                done = 0;
                counting = 0;
            S11:
                done = 0;
                counting = 0;
            S110:
                done = 0;
                counting = 0;
            B0:
                done = 0;
                counting = 0;
            B1:
                done = 0;
                counting = 0;
            B2:
                done = 0;
                counting = 0;
            B3:
                done = 0;
                counting = 0;
            Count:
                done = 0;
                counting = 1;
            Wait:
                done = 1;
                counting = 0;
            default:
                done = 0;
                counting = 0;
        endcase
    end
endmodule
