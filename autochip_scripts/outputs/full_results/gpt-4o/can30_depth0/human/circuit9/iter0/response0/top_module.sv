module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    reg [2:0] count;
    
    always @(posedge clk) begin
        if (a) begin
            count <= 4;
        end else begin
            if (count == 6)
                count <= 0;
            else
                count <= count + 1;
        end
        q <= count;
    end
    
endmodule
