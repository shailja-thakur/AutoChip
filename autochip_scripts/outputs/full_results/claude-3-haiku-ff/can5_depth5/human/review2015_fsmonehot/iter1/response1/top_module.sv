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

    // Next-state logic
    always @(*) begin
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (1'b1) // Casex is not synthesizable, so we use a simple case statement
            state[0]: begin // State S
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            state[1]: begin // State S1
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            state[2]: begin // State S11
                if (d) begin
                    S11_next = 1'b1;
                end else begin
                    S110_next = 1'b1;
                end
            end
            state[3]: begin // State S110
                if (d) begin
                    B0_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            state[4]: begin // State B0
                B1_next = 1'b1;
            end
            state[5]: begin // State B1
                B2_next = 1'b1;
            end
            state[6]: begin // State B2
                B3_next = 1'b1;
            end
            state[7]: begin // State Count
                if (done_counting) begin
                    Wait_next = 1'b1;
                end else begin
                    Count_next = 1'b1;
                end
            end
            state[8]: begin // State Wait
                if (ack) begin
                    S_next = 1'b1;
                end else begin
                    Wait_next = 1'b1;
                end
            end
            default: begin
                // Remain in current state
            end
        endcase
    end

    // Output logic
    always @(*) begin
        done = state[8];
        counting = state[7];
        shift_ena = state[4] | state[5] | state[6] | state[7];
    end

endmodule
