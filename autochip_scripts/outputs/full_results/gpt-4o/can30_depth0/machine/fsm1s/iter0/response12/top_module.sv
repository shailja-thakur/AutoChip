module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state;
    reg next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Sequential logic block to update the state at the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initial state B on reset
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
