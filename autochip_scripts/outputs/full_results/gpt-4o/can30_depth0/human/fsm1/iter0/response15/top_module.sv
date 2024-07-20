module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    
    // State representation
    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // Asynchronous reset and state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B; // Asynchronously reset to state B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: next_state = (in == 1'b0) ? STATE_B : STATE_A;
            STATE_B: next_state = (in == 1'b0) ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
