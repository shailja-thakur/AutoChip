module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
);
    
    reg [7:0] next_q;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            next_q <= 8'b0;
        else
            next_q <= d;
    end
    
    always @(posedge clk) begin
        q <= next_q;
    end
endmodule
