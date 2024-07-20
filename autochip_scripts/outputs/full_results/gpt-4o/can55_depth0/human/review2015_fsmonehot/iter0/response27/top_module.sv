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
        // Default outputs
        S_next = 1'b0;
        S1_next = 1'b0;
        B3_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;
        
        case (state)
            S: begin
                if (d == 1)
                    S1_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            S1: begin
                if (d == 1)
                    S11_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            S11: begin
                if (d == 1)
                    S11_next = 1'b1;
                else
                    S110_next = 1'b1;
            end
            S110: begin
                if (d == 1)
                    B0_next = 1'b1;
                else
                    S_next = 1'b1;
            end
            B0: begin
                shift_ena = 1'b1;
                B1_next = 1'b1;
            end
            B1: begin
                shift_ena = 1'b1;
                B2_next = 1'b1;
            end
            B2: begin
                shift_ena = 1'b1;
                B3_next = 1'b1;
            end
            B3: begin
                shift_ena = 1'b1;
                Count_next = 1'b1;
            end
            Count: begin
                counting = 1'b1;
                if (done_counting)
                    Wait_next = 1'b1;
                else
                    Count_next = 1'b1;
            end
            Wait: begin
                done = 1'b1;
                if (ack == 1)
                    S_next = 1'b1;
                else
                    Wait_next = 1'b1;
            end
            default: begin
                S_next = 1'b1;  // Default initial state on reset
            end
        endcase
    end

endmodule
