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
        10'b0000000001: begin
            B3_next = 1'b0;
            S_next = 1'b1;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        10'b0000000010: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b1;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        10'b1000000000: begin
            B3_next = ack & (~shift_ena);
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        10'b0000000100: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b1;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b1;
            shift_ena = 1'b0;
        end
        10'b1000000001: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b1;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
        10'b1000000010: begin
            B3_next = 1'b1;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b1;
        end
        default: begin
            B3_next = 1'b0;
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            done = 1'b0;
            counting = 1'b0;
            shift_ena = 1'b0;
        end
    endcase
end

endmodule
