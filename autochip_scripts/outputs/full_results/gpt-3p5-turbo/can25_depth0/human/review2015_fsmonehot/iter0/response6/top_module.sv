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
        // S () --d=0--> S
        // S () --d=1--> S1
        10'b0000000001:
            begin
                S_next = d;
                S1_next = ~d;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        // S1 () --d=0--> S
        // S1 () --d=1--> S11
        10'b0000000010:
            begin
                S_next = ~d;
                S1_next = d;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        // S11 () --d=0--> S110
        // S11 () --d=1--> S11
        10'b0000000100:
            begin
                S_next = 0;
                S1_next = ~d;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        // S110 () --d=0--> S
        // S110 () --d=1--> B0
        10'b0000001000:
            begin
                S_next = d;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
            end
        // B0 (shift_ena=1) -- (always go to next cycle) --> B1
        10'b0000010000:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 1;
                Count_next = 0;
                Wait_next = 0;
                shift_ena = 1;
            end
        // B1 (shift_ena=1) -- (always go to next cycle) --> B2
        10'b0000100000:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
                shift_ena = 1;
            end
        // B2 (shift_ena=1) -- (always go to next cycle) --> B3
        10'b0001000000:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
                shift_ena = 1;
            end
        // B3 (shift_ena=1) -- (always go to next cycle) --> Count
        10'b0010000000:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 1;
                Wait_next = 0;
                shift_ena = 1;
            end
        // Count (counting=1) --!(done_counting)--> Count
        // Count (counting=1) --(done_counting)--> Wait
        10'b0100000000:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = counting & ~done_counting;
                Wait_next = counting & done_counting;
                shift_ena = 0;
            end
        // Wait (done=1) --ack=0--> Wait
        // Wait (done=1) --ack=1--> S
        10'b1000000000:
            begin
                S_next = ack;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = done & ~ack;
                shift_ena = 0;
            end
        default:
            begin
                S_next = 0;
                S1_next = 0;
                B3_next = 0;
                Count_next = 0;
                Wait_next = 0;
                shift_ena = 0;
            end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        state <= 'b0;
    end else begin
        state <= next_state;
    end
end

always @(posedge clk) begin
    case (state)
        // B3 (shift_ena=1) -- (always go to next cycle) --> Count
        10'b0010000000: counting <= 1;
        default: counting <= 0;
    endcase
end

always @(posedge clk) begin
    case (state)
        // Wait (done=1) --(ack=0)--> Wait
        // Wait (done=1) --(ack=1)--> S
        10'b1000000000: done <= 1;
        default: done <= 0;
    endcase
end

endmodule
