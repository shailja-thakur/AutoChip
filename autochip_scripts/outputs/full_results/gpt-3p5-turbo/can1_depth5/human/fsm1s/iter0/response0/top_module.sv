module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    reg state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 1'b0;
        else
            state <= next_state;
    end
    
    always @* begin
        case (state)
            1'b0: begin
                if (in)
                    next_state = 1'b0;
                else
                    next_state = 1'b1;
                out = 1'b1;
            end
            
            1'b1: begin
                if (in)
                    next_state = 1'b1;
                else
                    next_state = 1'b0;
                out = 1'b0;
            end
            
            default: begin
                next_state = 1'b0;
                out = 1'b0;
            end
        endcase
    end
    
endmodule
