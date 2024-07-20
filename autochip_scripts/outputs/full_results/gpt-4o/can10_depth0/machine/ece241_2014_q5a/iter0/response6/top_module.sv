module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Defining state parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state to A
        else
            state <= next_state; // Move to next state
    end
    
    // State machine case statement
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = C;
                else
                    next_state = A;
            end
            B: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A; // Default state
        endcase
    end
    
    // Output logic
    always @(state) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
endmodule
