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
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1)
            state[0]: begin // S
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            state[1]: begin // S1
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            state[2]: begin // S11
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    state[3] ? S_next = 1'b1 : B3_next = 1'b1; // S110 -> S, S11 -> B3
                end
            end
            state[7]: begin // Count
                if (done_counting) begin
                    Wait_next = 1'b1;
                end else begin
                    Count_next = 1'b1;
                end
            end
            state[8]: begin // B3
                if (d) begin
                    B3_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            state[9]: begin // Wait
                if (ack) begin
                    S_next = 1'b1;
                end else begin
                    Wait_next = 1'b1;
                end
            end
        endcase
    end

    // Output logic
    assign done = state[9];
    assign counting = state[7];
    assign shift_ena = state[4] | state[5] | state[6] | state[7];

endmodule
