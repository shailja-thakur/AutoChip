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

    always @(*) begin
        // Default values
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1)
            state[S]: begin
                if (d == 0) begin
                    S_next = 1'b1;
                end else begin
                    S1_next = 1'b1;
                end
            end

            state[S1]: begin
                if (d == 0) begin
                    S_next = 1'b1;
                end
            end

            state[S11]: begin
                // No specific outputs for state S11
            end
            
            state[S110]: begin
                if (d == 0) begin
                    S_next = 1'b1;
                end
            end
            
            state[B0], state[B1], state[B2], state[B3]: begin
                shift_ena = 1'b1;
                if (state[B3]) begin
                    Count_next = 1'b1;
                end
                if (state[B2]) begin
                    B3_next = 1'b1;
                end
            end
            
            state[Count]: begin
                counting = 1'b1;
                if (done_counting == 1'b0) begin
                    Count_next = 1'b1;
                end else begin
                    Wait_next = 1'b1;
                end
            end
            
            state[Wait]: begin
                done = 1'b1;
                if (ack == 1'b1) begin
                    S_next = 1'b1;
                end else begin
                    Wait_next = 1'b1;
                end
            end
        endcase
    end

endmodule
