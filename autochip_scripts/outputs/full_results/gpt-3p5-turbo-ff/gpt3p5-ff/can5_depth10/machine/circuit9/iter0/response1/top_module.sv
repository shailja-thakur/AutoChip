module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    
    always @(posedge clk) begin
        if (a == 1'b1)
            q <= 3'b100;
        else if (a == 1'b0) begin
            if (q == 3'b110)
                q <= 3'b000;
            else
                q <= q + 1;
        end
    end
    
endmodule
