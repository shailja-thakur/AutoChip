module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0, // Start state / after a 0 or reset
        S1, // after 1
        S2, // after 11
        S3, // after 111
        S4, // after 1111
        S5, // after 11111
        S6, // after 111110 (zero after 5 ones)
        S7  // after 111111 (error state)
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
            S5: next_state = in ? S7 : S6; // Transition to error state on 6th 1
            S6: next_state = in ? S1 : S0; // Zero detected after 5 ones
            S7: next_state = in ? S7 : S0; // Remain in error state if 1, reset on 0
            default: next_state = S0;
        endcase
    end

    // State update on clock edge
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            // Output assignments based on the previous state (Moore FSM)
            disc <= (state == S5 && next_state == S6);
            flag <= (state == S5 && next_state == S7);
            err  <= (state == S7);
        end
    end

endmodule
