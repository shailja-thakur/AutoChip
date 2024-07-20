module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    parameter OFF = 1'b0;
    parameter ON = 1'b1;
    
    reg state, next_state;
    
    // State transition logic
    always @* begin
        case (state)
            OFF: begin
                if (j) 
                    next_state = ON;
                else 
                    next_state = OFF;
            end
            ON: begin
                if (k) 
                    next_state = OFF;
                else 
                    next_state = ON;
            end
        endcase
    end
    
    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(state) begin
        case (state)
            OFF: out = 1'b0;
            ON: out = 1'b1;
        endcase
    end
endmodule
