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

    // State definitions
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

    // Signal assignments
    always @* begin
        shift_ena = (state & {B3, B2, B1, B0}) ? 1 : 0;
        done = (state == Wait) ? 1 : 0;
        counting = (state == Count) ? 1 : 0;

        case(state)
            S: begin
                B3_next = 0;
                S_next = (d == 0) ? 1 : 0;
                S1_next = (d == 1) ? 1 : 0;
                Count_next = 0;
                Wait_next = (ack == 1) ? 1 : 0;
            end
            S1: begin
                B3_next = 0;
                S_next = (d == 0) ? 1 : 0;
                S1_next = (d == 1) ? 1 : 0;
                Count_next = 0;
                Wait_next = (ack == 1) ? 1 : 0;
            end
            S110: begin
                B3_next = 0;
                S_next = (d == 0) ? 1 : 0;
                S1_next = (d == 1) ? 1 : 0;
                Count_next = 0;
                Wait_next = (ack == 1) ? 1 : 0;
            end
            B0: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            B1: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            B2: begin
                B3_next = 1;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            B3: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 1;
                Wait_next = 0;
            end
            Count: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = (done_counting == 0) ? 1 : 0;
                Wait_next = (ack == 0) ? 1 : 0;
            end
            Wait: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = (done_counting == 1) ? 1 : 0;
                Wait_next = (ack == 0) ? 1 : 0;
            end
            default: begin
                B3_next = 0;
                S_next = 0;
                S1_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end

endmodule
