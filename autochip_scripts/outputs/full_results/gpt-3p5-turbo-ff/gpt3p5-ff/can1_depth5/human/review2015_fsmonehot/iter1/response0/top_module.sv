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
    // Next state logic
    case(state)
        10'b0000000001: S_next = !d;     // S
        10'b0000000010: S1_next = !d;    // S1
        10'b0000001000: S_next = 1'b1;   // S110
        10'b0000000100: S11_next = d;    // S11
        10'b0000001100: S11_next = d;    // S11
        10'b0001000000: shift_ena = 1'b1;    // B0
        10'b0000100000: shift_ena = 1'b1;    // B1
        10'b0000010000: shift_ena = 1'b1;    // B2
        10'b0000001000: B3_next = 1'b1;   // B3
        10'b0000000100: Count_next = counting && !done_counting;   // Count
        10'b0000000010: Wait_next = done && !ack;    // Wait
        default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            S11_next = 1'b0;
            B3_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

always @(posedge clk) begin
    // State updates
    if (reset) begin
        state <= 10'b0000000001;    // Start in state S
    end else begin
        state <= S_next ? 10'b0000000001 :
                  S1_next ? 10'b0000000010 :
                  S11_next ? 10'b0000000100 :
                  S110_next ? 10'b0001000000 :
                  B0_next ? 10'b0000100000 :
                  B1_next ? 10'b0000010000 :
                  B2_next ? 10'b0000001000 :
                  B3_next ? 10'b0000000100 :
                  Count_next ? 10'b0000000100 :
                  Wait_next ? 10'b0000000010 :
                  state;
    end
end

// Output logic
always @(*) begin
    done = state[9];
    counting = state[8];
end

endmodule
