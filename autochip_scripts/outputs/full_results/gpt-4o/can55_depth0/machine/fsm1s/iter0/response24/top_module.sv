module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // Default state in case of unexpected behavior
        endcase
    end
    
    // Sequential logic block triggered on the rising edge of the clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        out = (state == B);
    end
    
endmodule
