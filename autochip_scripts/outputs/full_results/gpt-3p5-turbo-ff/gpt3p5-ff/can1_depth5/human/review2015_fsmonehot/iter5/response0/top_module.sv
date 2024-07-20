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
        10'b0000000100: B3_next = 1'b1;   // S11
        10'b0000001000: S_next = 1'b1;    // S110
        10'b0000001000: B3_next = 1'b1;   // B0
        10'b0000010000: B3_next = 1'b1;   // B1
        10'b0000100000: B3_next = 1'b1;   // B2
        10'b0001000000: B3_next = 1'b1;   // B3
        10'b0000000100: Count_next = counting && !done_counting;   // Count
        10'b0000000010: Wait_next = done && !ack;    // Wait
        default: begin
            S_next = 1'b0;
            S1_next = 1'b0;
            Count_next = 1'b0;
            Wait_next = 1'b0;
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    // State updates
    if (reset) begin
        state <= 10'b0000000001;    // Start in state S
    end else begin
        state <= S_next ? 10'b0000000001 :
                  S1_next ? 10'b0000000010 :
                  S11_next ? 10'b0000000100 :
                  B3_next ? 10'b0000001000 :
                  Count_next ? 10'b0000001000 :
                  Wait_next ? 10'b0000000010 :
                  state;
    end
end

// Output logic
always @(*) begin
    done = state[9];
    counting = state[8];
    shift_ena = (state[7:4] == 4'b0001) ? 1'b1 : 1'b0;
end

endmodule
