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
    case(state)
        10'b0000000001: begin // State S
            S_next = (d == 1) ? 0 : 1;
            S1_next = (d == 1) ? 0 : 1;
            Count_next = (d == 1) ? 0 : 1;
            Wait_next = (d == 1) ? 0 : 1;
            B3_next = 0;
        end
        10'b0000000010: begin // State S1
            S_next = (d == 1) ? 0 : 1;
            S1_next = (d == 1) ? 0 : 1;
            Count_next = (d == 1) ? 0 : 1;
            Wait_next = (d == 1) ? 0 : 1;
            B3_next = 0;
        end
        10'b0000000100: begin // State S11
            S_next = (d == 1) ? 0 : 1;
            S1_next = (d == 1) ? 0 : 1;
            Count_next = (d == 1) ? 0 : 1;
            Wait_next = (d == 1) ? 0 : 1;
            B3_next = 0;
        end
        10'b0000001000: begin // State S110
            S_next = (d == 1) ? 0 : 1;
            S1_next = (d == 1) ? 0 : 1;
            Count_next = (d == 1) ? 0 : 1;
            Wait_next = (d == 1) ? 0 : 1;
            B3_next = (d == 1) ? 1 : 0;
        end
        10'b0000010000: begin // State B0
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 1;
        end
        10'b0000100000: begin // State B1
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 1;
        end
        10'b0001000000: begin // State B2
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 1;
        end
        10'b0010000000: begin // State B3
            S_next = 0;
            S1_next = 0;
            Count_next = 0;
            Wait_next = 0;
            B3_next = 1;
        end
        10'b0100000000: begin // State Count
            S_next = 0;
            S1_next = 0;
            Count_next = (done_counting == 1) ? 0 : 1;
            Wait_next = (done_counting == 1) ? 1 : 0;
            B3_next = 0;
        end
        10'b1000000000: begin // State Wait
            S_next = 10'b0000000001;
            S1_next = 10'b0000000010;
            Count_next = 10'b0100000000;
            Wait_next = 10'b1000000000;
            B3_next = 0;
        end
    endcase
end

always @(state) begin
    case(state)
        10'b0000000001: begin // State S
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000000010: begin // State S1
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000000100: begin // State S11
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000001000: begin // State S110
            done = 0;
            counting = 0;
            shift_ena = 0;
        end
        10'b0000010000: begin // State B0
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0000100000: begin // State B1
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0001000000: begin // State B2
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0010000000: begin // State B3
            done = 0;
            counting = 0;
            shift_ena = 1;
        end
        10'b0100000000: begin // State Count
            done = 0;
            counting = 1;
            shift_ena = 0;
        end
        10'b1000000000: begin // State Wait
            done = 1;
            counting = 0;
            shift_ena = 0;
        end
    endcase
end

endmodule
