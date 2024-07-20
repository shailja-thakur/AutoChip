module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State registers
    reg state, next_state;
    
    // FSM state transition (combinational)
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // This should never happen
        endcase
    end
    
    // FSM state update (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end
endmodule
