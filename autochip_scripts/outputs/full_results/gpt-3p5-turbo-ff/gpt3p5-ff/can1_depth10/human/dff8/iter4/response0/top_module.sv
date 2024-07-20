module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_reg;
    reg [7:0] d_reg;
    
    always @(posedge clk) begin
        d_reg <= d;
        q_reg <= d_reg;
    end
    
    always @(posedge clk) begin
        q <= q_reg;
    end
    
endmodule
