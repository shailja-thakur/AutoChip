module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declaration
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // State transition on clock posedge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;       // If asynchronous reset, go to state A
        else
            state <= next_state; // Else transition to next state
    end
    
    // Determine next state based on current state and input x
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
        endcase
    end
    
    // Output z logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
        endcase
    end

endmodule
