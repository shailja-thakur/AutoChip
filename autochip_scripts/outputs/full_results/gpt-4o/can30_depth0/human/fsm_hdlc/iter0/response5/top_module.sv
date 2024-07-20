module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum logic[2:0] {
        S0, // initial/reset state, behaves as if prior input was 0
        S1, // seen 0
        S2, // seen 01
        S3, // seen 011
        S4, // seen 0111
        S5, // seen 01111
        S6, // seen 011111
        S7 // seen 0111111
    } state_t;

    state_t state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;
            disc <= (state == S6 && in == 0) ? 1'b1 : 1'b0;
            flag <= (state == S6 && in == 1) ? 1'b1 : 1'b0;
            err <= (state == S7 && in == 1) ? 1'b1 : 1'b0;
        end
    end

    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0; // remain in err state for continuous 1s
            default: next_state = S0;
        endcase
    end

endmodule
