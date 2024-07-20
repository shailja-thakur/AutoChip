module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 1'b0;
        end else begin
            if (state == 1'b0) begin
                state <= (in == 1'b1) ? 1'b0 : 1'b1;
            end else if (state == 1'b1) begin
                state <= (in == 1'b1) ? 1'b1 : 1'b0;
            end
        end
    end
    
    assign out = (state == 1'b1) ? 1'b1 : 1'b0;
    
endmodule
