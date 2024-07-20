module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state;
    reg next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B;  // Default to state B
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B)
            out = 1'b1;  // Out is high when in state B
        else
            out = 1'b0;  // Out is low when in state A
    end

endmodule
