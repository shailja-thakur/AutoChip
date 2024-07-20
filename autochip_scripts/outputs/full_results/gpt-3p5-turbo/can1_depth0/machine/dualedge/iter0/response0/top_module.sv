module top_module(
    input clk,
    input d,
    output reg q
);
    reg qp;   // register for positive edge of clk
    reg qn;   // register for negative edge of clk
    
    always @(posedge clk) begin
        qp <= d;
    end
    
    always @(negedge clk) begin
        qn <= d;
    end
    
    always @(clk) begin
        if (clk) begin
            q <= qp;
        end else begin
            q <= qn;
        end
    end
endmodule
