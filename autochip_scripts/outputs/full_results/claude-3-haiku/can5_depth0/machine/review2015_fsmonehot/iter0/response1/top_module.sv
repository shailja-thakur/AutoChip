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

always @(*) begin
    // Default outputs
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    // Output logic
    if (state == B2) begin
        B3_next = 1;
    end

    if ((state == S && !d) || (state == S1 && !d) || (state == S110 && !d) || (state == Wait && ack)) begin
        S_next = 1;
    end

    if (state == S && d) begin
        S1_next = 1;
    end

    if (state == B3 || (state == Count && !done_counting)) begin
        Count_next = 1;
    end

    if ((state == Count && done_counting) || (state == Wait && !ack)) begin
        Wait_next = 1;
    end

    if (state == B3 || state == B2 || state == B1 || state == B0) begin
        shift_ena = 1;
    end

    if (state == Wait) begin
        done = 1;
    end

    if (state == Count) begin
        counting = 1;
    end
end

endmodule
