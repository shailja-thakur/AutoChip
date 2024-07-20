module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg S110_next,
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
        S110_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (state)
            10'b0000000001: begin // S
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            10'b0000000010: begin // S1
                if (d) begin
                    S1_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            10'b0000000100: begin // S11
                if (~d) begin
                    S110_next = 1'b1;
                end else begin
                    S11_next = 1'b1;
                end
            end
            10'b0000001000: begin // S110
                if (d) begin
                    B3_next = 1'b1;
                end else begin
                    S_next = 1'b1;
                end
            end
            10'b0000010000: begin // B0
                B3_next = 1'b1;
            end
            10'b0000100000: begin // B1
                B3_next = 1'b1;
            end
            10'b0001000000: begin // B2
                B3_next = 1'b1;
            end
            10'b0010000000: begin // B3
                Count_next = 1'b1;
            end
            10'b0100000000: begin // Count
                if (done_counting) begin
                    Wait_next = 1'b1;
                end else begin
                    Count_next = 1'b1;
                end
            end
            10'b1000000000: begin // Wait
                if (ack) begin
                    S_next = 1'b1;
                end else begin
                    Wait_next = 1'b1;
                end
            end
            default: begin
                S_next = 1'b1;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        case (state)
            10'b0000010000, 10'b0000100000, 10'b0001000000, 10'b0010000000: begin // B0, B1, B2, B3
                shift_ena = 1'b1;
            end
            10'b0100000000: begin // Count
                counting = 1'b1;
            end
            10'b1000000000: begin // Wait
                done = 1'b1;
            end
        endcase
    end

endmodule
