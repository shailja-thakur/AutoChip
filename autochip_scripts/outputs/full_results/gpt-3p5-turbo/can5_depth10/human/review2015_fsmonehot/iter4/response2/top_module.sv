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
        10'b0000000001: begin
            S_next = ~d;
            S1_next = d;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0000000010: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0000000100: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0000001000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0000010000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = counting & ~done_counting;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0000100000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = counting & ~done_counting;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0001000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = counting & ~done_counting;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0010000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = counting & ~done_counting;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b0100000000: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = counting & ~done_counting;
            Wait_next = 1'b0;
            B3_next = 1'b0;
        end
        10'b1000000000: begin
            S_next = ack;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
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
end

always @(posedge clk) begin
    S <= S_next;
    S1 <= S1_next;
    Count <= Count_next;
    Wait <= Wait_next;
    B3 <= B3_next;
end

always @(*) begin
    shift_ena = (B3 | Count | Wait);
end

always @(posedge clk) begin
    done <= (Wait & ack);
    counting <= Count;
end

endmodule
