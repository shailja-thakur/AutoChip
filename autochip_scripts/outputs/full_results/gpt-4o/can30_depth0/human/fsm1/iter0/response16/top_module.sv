module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B; // Asynchronous reset to state B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default state
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 1'b1; // Output for state B
        end else begin
            case (state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b1;
                default: out <= 1'b1; // Default output
            endcase
        end
    end

endmodule
