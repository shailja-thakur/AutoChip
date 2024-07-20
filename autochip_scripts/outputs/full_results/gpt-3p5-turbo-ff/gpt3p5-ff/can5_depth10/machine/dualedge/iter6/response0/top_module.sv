module top_module(
    input clk,
    input d,
    output reg q
);
    
    always @(posedge clk) begin
        if (clk) begin
            qp <= d;
            q <= qp;
        end 
        else begin
            qn <= d;
            q <= qn;
        end
    end
    
endmodule
