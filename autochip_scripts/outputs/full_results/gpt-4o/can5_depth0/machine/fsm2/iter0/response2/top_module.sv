module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // Current state and next state variables
    reg state, next_state;
    
    // Combinational block to determine next state
    always @(*) begin
        // Default to stay in the same state
        next_state = state;
        case (state)
            A: begin
                if (j) next_state = B;
            end
            B: begin
                if (k) next_state = A;
            end
        endcase
    end
    
    // Clocked block to update state
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
