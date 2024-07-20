module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // State encoding using one-hot
    parameter A = 1'b0, B = 1'b1;

    // State registers
    reg state, next_state;
    
    // Output logic
    assign z = (state == B) ? ~x : x;

    // State transition logic (next state determination)
    always @(*) begin
        case (state)
            A: next_state = (x == 1) ? B : A;
            B: next_state = B;
            default: next_state = A;  // Should not occur
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset to state A
        else
            state <= next_state;
    end
endmodule
