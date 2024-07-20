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
    localparam S      = 10'b0000000001;
    localparam S1     = 10'b0000000010;
    localparam S11    = 10'b0000000100;
    localparam S110   = 10'b0000001000;
    localparam B0     = 10'b0000010000;
    localparam B1     = 10'b0000100000;
    localparam B2     = 10'b0001000000;
    localparam B3     = 10'b0010000000;
    localparam Count  = 10'b0100000000;
    localparam Wait   = 10'b1000000000;

    // Done signal logic
    always @(*) begin
        done = (state == Wait);
    end

    // Counting signal logic
    always @(*) begin
        counting = (state == Count);
    end

    // Shift enable signal logic
    always @(*) begin
        shift_ena = (state == B0 || state == B1 || state == B2 || state == B3);
    end

    // B3_next signal logic
    always @(*) begin
        B3_next = (state == B2);
    end

    // S_next signal logic
    always @(*) begin
        S_next = ((state == S && !d) || (state == S1 && !d) || (state == S110 && !d) || (state == Wait && ack));
    end

    // S1_next signal logic
    always @(*) begin
        S1_next = (state == S && d);
    end

    // Count_next signal logic
    always @(*) begin
        Count_next = (state == B3 || (state == Count && !done_counting));
    end

    // Wait_next signal logic
    always @(*) begin
        Wait_next = ((state == Count && done_counting) || (state == Wait && !ack));
    end
endmodule
