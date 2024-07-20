module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg state;
    reg prev_in;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b0;
        else
            state <= (state == 1'b0 && prev_in) || (state == 1'b1 && !prev_in);
        
        prev_in <= in;
    end
    
    assign out = (state == 1'b1);
    
endmodule
