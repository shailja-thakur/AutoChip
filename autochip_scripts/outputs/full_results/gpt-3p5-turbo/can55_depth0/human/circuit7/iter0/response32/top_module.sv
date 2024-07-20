module top_module (
    input clk,
    input a, 
    output reg q
);
    
    always @(posedge clk) begin
        if (a == 1'b0)
            q <= q;
        else
            q <= ~q;
    end
    
endmodule
