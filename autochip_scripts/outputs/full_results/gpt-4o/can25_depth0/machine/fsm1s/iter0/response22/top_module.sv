module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state;
    reg next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A; // Default state for safety
        endcase
    end

    // Sequential block to update state on clock's rising edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
