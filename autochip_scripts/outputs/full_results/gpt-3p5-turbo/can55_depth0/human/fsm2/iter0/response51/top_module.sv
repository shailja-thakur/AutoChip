module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    parameter OFF = 0;
    parameter ON = 1;
    
    reg state, next_state;
    reg out_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    always @(state or j or k) begin
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
    
    always @(state) begin
        case (state)
            OFF: out_reg = 0;
            ON: out_reg = 1;
        endcase
    end
    
    assign out = out_reg;
    
endmodule
