module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define the states using parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A; // Reset state
        else 
            state <= next_state;
    end
    
    // Combinational logic for next state
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
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
   
endmodule
