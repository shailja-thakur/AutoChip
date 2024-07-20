module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // State Encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State Register
    reg state, next_state;
    
    // State Update on Clock Edge or Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next State Logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B; // B state remains B
            end
            default: next_state = A;
        endcase
    end
    
    // Output Logic
    always @(*) begin
        if (state == A && x == 1)
            z = 1;
        else if (state == B && x == 0)
            z = 1;
        else
            z = 0;
    end
    
endmodule
