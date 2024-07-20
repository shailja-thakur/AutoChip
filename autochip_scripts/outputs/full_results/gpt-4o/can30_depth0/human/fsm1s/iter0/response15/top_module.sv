module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_B: next_state = in ? STATE_B : STATE_A;
            STATE_A: next_state = in ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default state
        endcase
    end

    // Update current state on clock edge
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_B; // Reset state
        else
            current_state <= next_state;
    end

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1; // Default output
        endcase
    end

endmodule
