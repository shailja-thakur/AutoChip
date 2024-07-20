module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state encoding
    parameter A = 1'b0, B = 1'b1;
    
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state to A
        else
            state <= next_state; // Update state
    end

    // Output logic
    always @(state) begin
        out = (state == B) ? 1 : 0;
    end

endmodule
