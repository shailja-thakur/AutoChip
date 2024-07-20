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

    parameter S = 0;
    parameter S1 = 1;
    parameter S11 = 2;
    parameter S110 = 3;
    parameter B0 = 4;
    parameter B1 = 5;
    parameter B2 = 6;
    parameter B3 = 7;
    parameter Count = 8;
    parameter Wait = 9;

    always @(state, d, ack, done_counting) begin
        case(state)
            S: begin
                S_next = (d == 0);
                S1_next = (d == 1);
                B3_next = 0;
                Count_next = 0;
                Wait_next = (ack == 1);
            end
            S1: begin
                S_next = (d == 0);
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = (ack == 1);
            end
            S11: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            S110: begin
                S_next = (d == 0);
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = (ack == 1);
            end
            B0: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            B1: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
            B2: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 1;
                Count_next = 0;
                Wait_next = 0;
            end
            B3: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 1;
                Wait_next = 0;
            end
            Count: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = (done_counting == 0) || (state == B3);
                Wait_next = (done_counting == 1);
            end
            Wait: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = (ack == 0);
            end
            default: begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        endcase
    end

    assign done = (state == Wait);
    assign counting = (state == Count);
    assign shift_ena = (state == B3) || (state == B2) || (state == B1) || (state == B0);

endmodule
