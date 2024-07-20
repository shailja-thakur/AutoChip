module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // States
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state;
    reg next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A; // Default to state A to prevent latches
        endcase
    end

    // Sequential logic block to update state on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
