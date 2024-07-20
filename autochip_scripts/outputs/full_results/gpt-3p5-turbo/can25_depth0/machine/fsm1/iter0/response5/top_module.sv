module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state;
    wire next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 1'b0;
        else
            state <= next_state;
    end
    
    assign next_state = (state == 1'b0 && in) ? 1'b0 :
                       (state == 1'b1 && in) ? 1'b1 :
                       (state == 1'b0 && !in) ? 1'b1 :
                       (state == 1'b1 && !in) ? 1'b0 : 1'b0;
    
    assign out = (state == 1'b1) ? 1'b1 : 1'b0;
        
endmodule
