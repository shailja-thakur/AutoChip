module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;
    
    // State registers
    reg state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B; // Default case to avoid latches
        endcase
    end
    
    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // Reset state to B
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end
    
endmodule
