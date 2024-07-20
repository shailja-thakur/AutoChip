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
            S_next = d ? 1'b1 : 1'b0;
            S1_next = d ? 1'b0 : 1'b1;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000010: begin
            S_next = 1'b0;
            S1_next = d ? 1'b1 : 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000000100: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = d ? 1'b1 : 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000001000: begin
            S_next = d ? 1'b1 : 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0000010000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b1;
        end
        10'b0000100000: begin
            S_next = d ? 1'b1 : 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
        10'b0001000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b1;
        end
        10'b0010000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = ack ? 1'b1 : 1'b0;
        end
        default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

always @(*) begin
    case (state)
        10'b0010000000:
        10'b0000000100: counting = 1'b1;
        default: counting = 1'b0;
    endcase
end

always @(*) begin
    case (state)
        10'b0000100000: shift_ena = 1'b1;
        default: shift_ena = 1'b0;
    endcase
end

always @(*) begin
    done = state == 10'b0010000000 ? 1'b1 : 1'b0;
end

endmodule
