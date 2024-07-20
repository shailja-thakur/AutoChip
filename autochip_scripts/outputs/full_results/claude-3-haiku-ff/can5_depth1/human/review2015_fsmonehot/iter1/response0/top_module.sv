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
    output done,
    output counting,
    output shift_ena
 );

    // Next-state logic
    always @(*) begin
        B3_next = 0;
        S_next = 0;
        S1_next = 0;
        Count_next = 0;
        Wait_next = 0;

        case (1'b1)
            state[0]: // S
                if (d) begin
                    S1_next = 1;
                end else begin
                    S_next = 1;
                end
            state[1]: // S1
                if (d) begin
                    S1_next = 1;
                end else begin
                    S_next = 1;
                end
            state[2]: // S11
                if (d) begin
                    S1_next = 1;
                end else begin
                    S_next = 1;
                end
            state[3]: // S110
                if (d) begin
                    B3_next = 1;
                end else begin
                    S_next = 1;
                end
            state[8]: // B3
                if (!d) begin
                    B3_next = 1;
                end
            state[7]: // Count
                if (done_counting) begin
                    Wait_next = 1;
                end else begin
                    Count_next = 1;
                end
            state[9]: // Wait
                if (ack) begin
                    S_next = 1;
                end else begin
                    Wait_next = 1;
                end
        endcase
    end

    // Output logic
    assign done = state[9];
    assign counting = state[7];
    assign shift_ena = state[3] || state[4] || state[5] || state[6];

endmodule
