module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);

    reg [7:0] qtemp;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            qtemp <= 8'b0;
        else
            qtemp <= d;
    end
    
    always @(posedge clk) begin
        q <= qtemp;
    end
    
endmodule
