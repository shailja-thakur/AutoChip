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

// Logic for B3_next
always @* begin
    B3_next = (state == B2) ? 1'b1 : 1'b0;
end

// Logic for S_next
always @* begin
    S_next = ((state == S && d == 1'b0)
                || (state == S1 && d == 1'b0)
                || (state == S110 && d == 1'b0)
                || (state == Wait && ack == 1'b1)) ? 1'b1 : 1'b0;
end

// Logic for S1_next
always @* begin
    S1_next = (state == S && d == 1'b1) ? 1'b1 : 1'b0;
end

// Logic for Count_next
always @* begin
    Count_next = ((state == B3) || (state == Count && done_counting == 1'b0)) ? 1'b1 : 1'b0;
end

// Logic for Wait_next
always @* begin
    Wait_next = ((state == Count && done_counting == 1'b1)
                || (state == Wait && ack == 1'b0)) ? 1'b1 : 1'b0;
end

// Logic for done signal
always @* begin
    done = (state == Wait) ? 1'b1 : 1'b0;
end

// Logic for counting signal
always @* begin
    counting = (state == Count) ? 1'b1 : 1'b0;
end

// Logic for shift_ena signal
always @* begin
    shift_ena = ((state == B0) || (state == B1) || (state == B2) || (state == B3)) ? 1'b1 : 1'b0;
end

endmodule
