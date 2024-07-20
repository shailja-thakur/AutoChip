module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
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
    case (state)
        10'b0000000001: begin // State S
            S_next = d ? 1 : 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000010: begin // State S1
            S_next = 0;
            S1_next = d ? 10'b0000000100 : 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000100: begin // State S11
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0000000111: begin // State S110
            S_next = 0;
            S1_next = 0;
            B3_next = d ? 1 : 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0001010000: begin // State B0
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0010100000: begin // State B1
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0101000000: begin // State B2
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b1010000000: begin // State B3
            S_next = 0;
            S1_next = 0;
            B3_next = 1;
            Count_next = 0;
            Wait_next = 0;
        end
        10'b0100110000: begin // State Count
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = d ? 0 : (done_counting ? 10'b0000001010 : 1);
            Wait_next = 0;
        end
        10'b0000001000: begin // State Wait
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = done ? 1 : 0;
        end
        default: begin
            S_next = 0;
            S1_next = 0;
            B3_next = 0;
            Count_next = 0;
            Wait_next = 0;
        end
    endcase
end

always @* begin
    counting = (state == 10'b0100110000) ? 1 : 0;
    shift_ena = (state >= 10'b1010000000 && state < 10'b1011111111) ? 1 : 0;
    done = (state == 10'b0000001000) ? 1 : 0;
end

endmodule
