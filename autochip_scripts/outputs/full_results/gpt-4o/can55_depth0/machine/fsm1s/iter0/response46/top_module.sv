module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    
    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = A;
        endcase
    end
    
    // Sequential logic to update the state on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b1; // Output B is high on reset
        else
            out <= (state == B) ? 1'b1 : 1'b0;
    end

endmodule
