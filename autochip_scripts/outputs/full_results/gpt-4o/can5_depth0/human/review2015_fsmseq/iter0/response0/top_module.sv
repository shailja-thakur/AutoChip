module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'b000,
        S_S1   = 3'b001,
        S_S11  = 3'b010,
        S_S110 = 3'b011,
        S_S1101 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S_IDLE;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S_IDLE: next_state = data ? S_S1   : S_IDLE;
            S_S1  : next_state = data ? S_S11  : S_IDLE;
            S_S11 : next_state = data ? S_S11  : S_S110;
            S_S110: next_state = data ? S_S1101 : S_IDLE;
            S_S1101: next_state = S_S1101;  // Stays in this state forever until reset
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (current_state == S_S1101) begin
            start_shifting <= 1;
        end
    end

endmodule
