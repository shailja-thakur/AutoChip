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

    // State definitions for clarity
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;

    // Next state logic
    always @(*) begin
        // Initialize all next states to 0
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;

        case (1'b1) // synthesis parallel_case
            state[S]: begin
                if (d)
                    S1_next = 1;
                else
                    S_next = 1;
            end
            state[S1]: begin
                if (d)
                    S1_next = 0;
                    S11_next = 1;
                else
                    S_next = 1;
            end
            state[S11]: begin
                if (d == 0)
                    S110_next = 1;
                else
                    S1_next = 1;
            end
            state[S110]: begin
                if (d)
                    B0_next = 1;
                else
                    S_next = 1;
            end
            state[B0]: begin
                B1_next = 1;
            end
            state[B1]: begin
                B2_next = 1;
            end
            state[B2]: begin
                B3_next = 1;
            end
            state[B3]: begin
                Count_next = 1;
            end
            state[Count]: begin
                if (done_counting)
                    Wait_next = 1;
                else
                    Count_next = 1;
            end
            state[Wait]: begin
                if (ack)
                    S_next = 1;
                else
                    Wait_next = 1;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        done = (state == Wait);
        counting = (state == Count);
        shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);
    end

endmodule
