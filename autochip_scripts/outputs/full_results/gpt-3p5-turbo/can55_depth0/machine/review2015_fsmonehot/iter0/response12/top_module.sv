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

    // Define state parameters
    parameter S = 10'b0;
    parameter S1 = 10'b1;
    parameter S11 = 10'b10;
    parameter S110 = 10'b11;
    parameter B0 = 10'b100;
    parameter B1 = 10'b101;
    parameter B2 = 10'b110;
    parameter B3 = 10'b111;
    parameter Count = 10'b1000;
    parameter Wait = 10'b1001;

    // Assign default values to outputs
    always @(*) begin
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;
        done = 0;
        counting = 0;
        shift_ena = 0;
    end

    // Logic for B3_next output
    always @(state) begin
        B3_next = (state == B2);
    end

    // Logic for S_next output
    always @(state, d, ack) begin
        S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));
    end

    // Logic for S1_next output
    always @(state, d) begin
        S1_next = (state == S && d == 1);
    end

    // Logic for Count_next output
    always @(state, done_counting) begin
        Count_next = (state == B3 || (state == Count && done_counting == 0));
    end

    // Logic for Wait_next output
    always @(state, done_counting, ack) begin
        Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0);
    end

    // Logic for done output
    always @(state) begin
        done = (state == Wait);
    end

    // Logic for counting output
    always @(state) begin
        counting = (state == Count);
    end

    // Logic for shift_ena output
    always @(state) begin
        shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
    end

endmodule
