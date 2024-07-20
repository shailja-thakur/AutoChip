module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State declaration
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = A; // Default to state A for safety
        endcase
    end

    // Sequential logic to update the state on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
