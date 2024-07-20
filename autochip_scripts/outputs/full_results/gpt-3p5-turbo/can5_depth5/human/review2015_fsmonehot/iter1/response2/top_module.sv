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

always @* begin
    // State transition logic for B3
    B3_next = (state == 10'b0111111111);

    // State transition logic for S
    S_next = (state == 10'b0000000001 && !d) || (state == 10'b0000000000 && d);

    // State transition logic for S1
    S1_next = (state == 10'b0000000010 && !d) || (state == 10'b0000000001 && d);

    // State transition logic for Count
    Count_next = (state == 10'b1000000000 && !done_counting) || (state == 10'b1000000000 && done_counting);

    // State transition logic for Wait
    Wait_next = (state == 10'b1000000000 && done_counting && !ack) || (state == 10'b1000000000 && done_counting && ack);
end

always @(posedge clk) begin
    // Output logic
    if (state == 10'b1000000000 && done_counting && ack) begin
        done = 1;
    end else begin
        done = 0;
    end

    if (state == 10'b1000000000) begin
        counting = 1;
    end else begin
        counting = 0;
    end

    if (state >= 10'b0111111111) begin
        shift_ena = 1;
    end else begin
        shift_ena = 0;
    end
end

endmodule
