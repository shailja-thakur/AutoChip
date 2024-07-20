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

    // State constants
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

    wire in_S = state == S;
    wire in_S1 = state == S1;
    wire in_S11 = state == S11;
    wire in_S110 = state == S110;
    wire in_B0 = state == B0;
    wire in_B1 = state == B1;
    wire in_B2 = state == B2;
    wire in_B3 = state == B3;
    wire in_Count = state == Count;
    wire in_Wait = state == Wait;

    always @(*) begin
        // Default values
        S_next = 1'b0;
        S1_next = 1'b0;
        B3_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        // Next state logic
        if (in_S) begin
            if (d) 
                S1_next = 1'b1;
            else 
                S_next = 1'b1;
        end
        else if (in_S1) begin
            if (d) 
                S1_next = 1'b1;
            else 
                S_next = 1'b1;
        end
        else if (in_S11) begin
            if (d) 
                S1_next = 1'b1;
            else 
                S110_next = 1'b1;
        end
        else if (in_S110) begin
            if (d) 
                B0_next = 1'b1;
            else 
                S_next = 1'b1;
        end
        else if (in_B0) begin
            B1_next = 1'b1;
            shift_ena = 1'b1;
        end
        else if (in_B1) begin
            B2_next = 1'b1;
            shift_ena = 1'b1;
        end
        else if (in_B2) begin
            B3_next = 1'b1;
            shift_ena = 1'b1;
        end
        else if (in_B3) begin
            Count_next = 1'b1;
            shift_ena = 1'b1;
        end
        else if (in_Count) begin
            if (done_counting)
                Wait_next = 1'b1;
            else
                Count_next = 1'b1;
            counting = 1'b1;
        end
        else if (in_Wait) begin
            if (ack)
                S_next = 1'b1;
            Wait_next = 1'b1;
            done = 1'b1;
        end
    end
endmodule
