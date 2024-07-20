module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Sequential logic block to update state on rising edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B; // Initial state is B on reset
        else 
            state <= next_state; 
    end

    // Output logic
    always @(state) begin
        if (state == B)
            out = 1;
        else
            out = 0;
    end

endmodule
