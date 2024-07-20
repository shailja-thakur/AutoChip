module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [2:0] {
        S0 = 3'd0, // Start state
        S1 = 3'd1, // Seen 0
        S2 = 3'd2, // Seen 01
        S3 = 3'd3, // Seen 011
        S4 = 3'd4, // Seen 0111
        S5 = 3'd5, // Seen 01111
        S6 = 3'd6, // Seen 011111
        S7 = 3'd7  // Seen 0111111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            state <= next_state;
            disc <= (state == S6) && !in;
            flag <= (state == S6) && in;
            err <= (state == S7);
        end
    end
endmodule
