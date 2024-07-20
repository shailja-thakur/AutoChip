module top_module(
    input clk,
    input d,
    output reg q);
    
    reg q_reg;
    reg clk_div;

    always @(posedge clk) begin
        clk_div <= ~clk_div;
    end
    
    always @(posedge clk_div) begin
        q_reg <= d;
    end
    
    always @(posedge clk_div) begin
        q <= q_reg;
    end

endmodule
