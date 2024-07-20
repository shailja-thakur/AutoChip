module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states
    typedef enum reg {
        STATE_A,
        STATE_B
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = in ? STATE_A : STATE_B;
            STATE_B: next_state = in ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default state to handle unexpected cases
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
