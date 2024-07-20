module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case(state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Sequential logic to update state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initialize to state B on reset
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
