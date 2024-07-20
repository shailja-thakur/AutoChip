module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define the state parameters
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // State machine: sequential part
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Asynchronous reset to state A
        else
            state <= next_state;  // Update state on clock edge
    end
    
    // State machine: combinational part
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;  // State B remains state B
            end
            default: next_state = A;  // Default state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
