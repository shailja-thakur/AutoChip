module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum logic [0:0] {
        state_A = 1'b0,
        state_B = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            state_A: next_state = (in) ? state_A : state_B;
            state_B: next_state = (in) ? state_B : state_A;
            default: next_state = state_B; // default case to handle any other state
        endcase
    end

    // State update and reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= state_B; // Reset to state B
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        out = (current_state == state_B) ? 1'b1 : 1'b0;
    end

endmodule
