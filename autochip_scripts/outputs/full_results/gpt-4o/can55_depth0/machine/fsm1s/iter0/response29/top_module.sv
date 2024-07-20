module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A;
        endcase
    end

    // Sequential logic block to update state on rising edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset state to B
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b1;  // Reset the out to match state B
        else
            out <= (state == B);
    end

endmodule
