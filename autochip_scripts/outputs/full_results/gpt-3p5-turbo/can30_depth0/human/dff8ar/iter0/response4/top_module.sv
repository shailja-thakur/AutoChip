module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q
    );

    reg [7:0] q_tmp;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q_tmp <= 8'b0;
        end else begin
            q_tmp <= d;
        end
    end
    
    always @(posedge clk) begin
        if (!areset) begin
            q <= q_tmp;
        end
    end
    
endmodule
