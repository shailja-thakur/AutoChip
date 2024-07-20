module top_module(
    input clk,
    input d,
    output reg q
);
    reg qp, qn;
    
    always @(posedge clk)
        qp <= d;
    
    always @(negedge clk)
        qn <= d;
    
    always @(clk)
    begin
        if (clk)
            q <= qp;
        else
            q <= qn;
    end
    
endmodule
