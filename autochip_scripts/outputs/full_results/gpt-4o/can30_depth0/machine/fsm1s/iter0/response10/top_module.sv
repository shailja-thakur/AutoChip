module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // Define states as parameters
    parameter A = 1'b0, B = 1'b1;
    reg state;
    reg next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A; else next_state = B;
            B: if (in) next_state = B; else next_state = A;
            default: next_state = A; // Default case to handle unexpected scenario
        endcase
    end

    // Always block triggered on the rising edge of the clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to initial state B
        else
            state <= next_state; // Update state with next state
    end

    // Assign output based on state
    assign out = (state == B);

endmodule
