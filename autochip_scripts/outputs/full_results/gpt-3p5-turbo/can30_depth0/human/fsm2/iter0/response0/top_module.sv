module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    reg state;
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= 1'b0;
        else if (state == 1'b0) begin
            if (j)
                state <= 1'b1;
            else
                state <= 1'b0;
        end else begin
            if (k)
                state <= 1'b0;
            else
                state <= 1'b1;
        end
    end
    
    always @(state) begin
        if (state == 1'b0)
            out <= 1'b0;
        else
            out <= 1'b1;
    end
    
endmodule
