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

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: next_state = (j ? B : A);
            B: next_state = (k ? A : B);
            default: next_state = A;
        endcase
    end

    // Sequential logic for state transition and reset logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output logic
    always @(state) begin
        out = (state == B);
    end
endmodule
