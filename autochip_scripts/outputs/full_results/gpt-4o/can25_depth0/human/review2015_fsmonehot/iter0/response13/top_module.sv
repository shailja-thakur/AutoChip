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

// State encoding
parameter S = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S11 = 10'b0000000100;
parameter S110 = 10'b0000001000;
parameter B0 = 10'b0000010000;
parameter B1 = 10'b0000100000;
parameter B2 = 10'b0001000000;
parameter B3 = 10'b0010000000;
parameter Count = 10'b0100000000;
parameter Wait = 10'b1000000000;

// Next-state logic
always @(*) begin
    // Default next states to stay in the same state unless specified
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    
    case (1'b1)
        state[S]: begin
            if (d == 1)
                S1_next = 1;
            else
                S_next = 1;
        end

        state[S1]: begin
            if (d == 1)
                S1_next = 1;
            else
                S1_next = 0;
                S_next = 1;
        end

        state[S11]: begin
            if (d == 1)
                S11_next = 1;
            else
                S11_next = 0;
                S_next = 1;
        end

        state[S110]: begin
            if (d == 1)
                B0_next = 1;
            else
                S110_next = 0;
                S_next = 1;
        end

        state[B0]: begin
            B1_next = 1;
            shift_ena = 1;
        end

        state[B1]: begin
            B2_next = 1;
            shift_ena = 1;
        end

        state[B2]: begin
            B3_next = 1;
            shift_ena = 1;
        end

        state[B3]: begin
            Count_next = 1;
            shift_ena = 1;
        end

        state[Count]: begin
            if (done_counting)
                Wait_next = 1;
            else
                Count_next = 1;
            counting = 1;
        end

        state[Wait]: begin
            if (ack)
                S_next = 1;
            else
                Wait_next = 1;
            done = 1;
        end
    endcase
end

endmodule
