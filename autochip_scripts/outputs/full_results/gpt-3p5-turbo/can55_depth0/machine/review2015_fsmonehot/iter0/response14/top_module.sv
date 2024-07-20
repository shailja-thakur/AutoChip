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
    parameter S    = 10'd0;
    parameter S1   = 10'd1;
    parameter S11  = 10'd2;
    parameter S110 = 10'd3;
    parameter B0   = 10'd4;
    parameter B1   = 10'd5;
    parameter B2   = 10'd6;
    parameter B3   = 10'd7;
    parameter Count    = 10'd8;
    parameter Wait     = 10'd9;

    // Next state assignments
    always @(*)
    begin
        case(state)
            S: begin
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                S1_next = 0;
            end
            S1: begin
                if (d == 1)
                    S1_next = 1;
                else
                    S1_next = 0;
                S_next = 0;
            end
            S110: begin
                if (d == 0)
                    S_next = 1;
                else
                    S_next = 0;
                S1_next = 0;
            end
            Wait: begin
                if (ack == 1)
                    Wait_next = 1;
                else
                    Wait_next = 0;
            end
            default: begin
                S_next = 0;
                S1_next = 0;
                Wait_next = 0;
            end
        endcase
    end

    always @(*)
    begin
        case(state)
            B3: B3_next = 1;
            default: B3_next = 0;
        endcase
    end

    always @(*)
    begin
        case(state)
            B3: Count_next = 1;
            Count: begin
                if (done_counting == 0)
                    Count_next = 1;
                else
                    Count_next = 0;
            end
            default: Count_next = 0;
        endcase
    end

    always @(*)
    begin
        case(state)
            Count: Wait_next = 1;
            Wait: begin
                if (ack == 0)
                    Wait_next = 1;
                else
                    Wait_next = 0;
            end
            default: Wait_next = 0;
        endcase
    end

    // Output assignments
    assign done = (state == Wait);
    assign counting = (state == Count);
    assign shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);

endmodule
