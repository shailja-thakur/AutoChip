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

    // State transition logic
    always @ (*)
        case (state)
            10'b0000000001: begin  // S
                S_next = (d) ? 1'b0 : 1'b1;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0000000010: begin  // S1
                S_next = 1'b0;
                S1_next = (d) ? 1'b0 : 1'b1;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0000000100: begin  // S11
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0000001000: begin  // S110
                S_next = (d) ? 1'b1 : 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0000100000: begin  // B0
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0001000000: begin  // B1
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0010000000: begin  // B2
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b0100000000: begin  // B3
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b1;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
            10'b1000000000: begin  // Count
                S_next = 1'b0;
                S1_next = 1'b0;

                if (!done_counting) begin
                    Count_next = 1'b1;
                    Wait_next = 1'b0;
                end else begin
                    Count_next = 1'b0;
                    Wait_next = 1'b1;
                end

                B3_next = 1'b0;
            end
            10'b0000000001: begin  // Wait
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;

                if (ack) begin
                    Wait_next = 1'b1;
                    done = 1'b1;
                end else begin
                    Wait_next = 1'b0;
                    done = 1'b0;
                end

                B3_next = 1'b0;
            end
            default: begin
                S_next = 1'b0;
                S1_next = 1'b0;
                Count_next = 1'b0;
                Wait_next = 1'b0;
                B3_next = 1'b0;
            end
        endcase

    // Output logic
    always @ (*)
        case (state)
            10'b0100000000: begin  // B0
                counting = 1'b0;
                shift_ena = 1'b1;
                done = 1'b0;
            end
            10'b0010000000, 10'b0001000000, 10'b0000100000: begin  // B1, B2, B3
                counting = 1'b0;
                shift_ena = 1'b1;
                done = 1'b0;
            end
            10'b1000000000: begin  // Count
                counting = 1'b1;
                shift_ena = 1'b0;
                done = 1'b0;
            end
            10'b0000000001: begin  // Wait
                counting = 1'b0;
                shift_ena = 1'b0;
                done = 1'b0;
            end
            default: begin
                counting = 1'b0;
                shift_ena = 1'b0;
                done = 1'b0;
            end
        endcase

endmodule
