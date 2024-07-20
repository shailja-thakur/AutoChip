module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential block to update state on clock edge and reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
