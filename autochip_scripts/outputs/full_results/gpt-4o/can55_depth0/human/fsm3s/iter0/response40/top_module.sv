module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    // State registers
    reg [1:0] state, next_state;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A; // Reset state to A
        end else begin
            state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A; // Default to state A
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b0;
            STATE_C: out = 1'b0;
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
