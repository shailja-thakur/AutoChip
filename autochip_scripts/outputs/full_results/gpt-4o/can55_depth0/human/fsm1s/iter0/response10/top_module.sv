module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_B = 2'b00,
        STATE_A = 2'b01
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Output logic based on state
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1;
        endcase
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            default: next_state = STATE_B;
        endcase
    end

    // State update on clock edge
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_B; // Reset to state B
        end else begin
            current_state <= next_state;
        end
    end

endmodule
