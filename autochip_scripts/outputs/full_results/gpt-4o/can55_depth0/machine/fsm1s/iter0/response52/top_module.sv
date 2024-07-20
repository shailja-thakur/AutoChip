module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declaration
    parameter STATE_A = 0, STATE_B = 1;
    
    reg state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case (state)
            STATE_A: next_state = (in) ? STATE_A : STATE_B;
            STATE_B: next_state = (in) ? STATE_B : STATE_A;
            default: next_state = STATE_A; // default case for safety
        endcase
    end

    // Sequential logic block triggered on the clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_B; // Initial state on reset
        end else begin
            state <= next_state; // Update state
        end
    end

    // Output logic
    always @(*) begin
        out = (state == STATE_B);
    end

endmodule
