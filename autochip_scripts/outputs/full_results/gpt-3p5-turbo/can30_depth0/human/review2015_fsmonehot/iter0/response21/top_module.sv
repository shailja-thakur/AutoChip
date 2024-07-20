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
    case (state)
        10'b0000000001: begin  // S
            B3_next = 0;
            S_next = (d == 0) ? 10'b0000000001 : 10'b0000000010;
            S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000010;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000000010: begin  // S1
            B3_next = 0;
            S_next = (d == 0) ? 10'b0000000001 : 10'b0000000010;
            S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000010;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000000100: begin  // S11
            B3_next = 0;
            S_next = 10'b0000000100;
            S1_next = (d == 0) ? 10'b0000000001 : 10'b0000000110;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000000110: begin  // S110
            B3_next = (d == 1) ? 10'b0000100000 : 10'b0000000001;
            S_next = 10'b0000000100;
            S1_next = 10'b0000000110;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000100000: begin  // B0
            B3_next = 10'b0001000000;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0001000000: begin  // B1
            B3_next = 10'b0010000000;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0010000000: begin  // B2
            B3_next = 10'b0100000000;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0100000000: begin  // B3
            B3_next = 10'b1000000000;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b1000000000: begin  // Count
            B3_next = 0;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = (done_counting) ? 10'b1100000000 : 10'b1000000000;
            Wait_next = (done_counting) ? 10'b0010000000 : 10'b0000000000;
            done = 0;
            counting = 1;
            shift_ena = 0;
        end
        10'b1100000000: begin  // Wait
            B3_next = 0;
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = 10'b1000000000;
            Wait_next = (ack) ? 10'b0000000001 : 10'b1100000000;
            done = 1;
            counting = 0;
            shift_ena = 0;
        end
        default: begin
            B3_next = 0;
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
    endcase
end

endmodule
