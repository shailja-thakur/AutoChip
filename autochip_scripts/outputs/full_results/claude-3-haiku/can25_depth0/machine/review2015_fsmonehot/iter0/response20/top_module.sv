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

always @(*) begin
    // Initialize outputs to 0
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    // Set outputs based on current state
    case (state)
        10'b0000000001: begin // S
            S_next = (d == 0);
            S1_next = (d == 1);
        end
        10'b0000000010: begin // S1
            S1_next = (d == 1);
        end
        10'b0000000100: begin // S11
            // No outputs set
        end
        10'b0000001000: begin // S110
            S_next = (d == 0);
        end
        10'b0000010000: begin // B0
            shift_ena = 1;
        end
        10'b0000100000: begin // B1
            shift_ena = 1;
        end
        10'b0001000000: begin // B2
            B3_next = 1;
            shift_ena = 1;
        end
        10'b0010000000: begin // B3
            shift_ena = 1;
            Count_next = 1;
        end
        10'b0100000000: begin // Count
            counting = 1;
            Count_next = (done_counting == 0);
            Wait_next = (done_counting == 1);
        end
        10'b1000000000: begin // Wait
            done = 1;
            Wait_next = (ack == 0);
        end
    endcase
end

endmodule
