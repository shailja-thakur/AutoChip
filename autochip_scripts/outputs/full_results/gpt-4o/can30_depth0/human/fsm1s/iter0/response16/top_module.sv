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

    state_t current_state, next_state;

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_B; // Default reset state
        endcase
    end

    // State transition and output logic
    always @(posedge clk) begin
        if (reset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_B: out = 1;
            STATE_A: out = 0;
            default: out = 1;  // Default case
        endcase
    end
endmodule
