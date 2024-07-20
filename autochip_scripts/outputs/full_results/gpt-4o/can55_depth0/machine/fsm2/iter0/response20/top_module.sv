module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define the states as parameters
    parameter A = 1'b0, B = 1'b1;

    // State registers
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A;
        endcase
    end

    // Sequential logic to update the state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else
            out <= (state == B) ? 1'b1 : 1'b0;
    end
endmodule
