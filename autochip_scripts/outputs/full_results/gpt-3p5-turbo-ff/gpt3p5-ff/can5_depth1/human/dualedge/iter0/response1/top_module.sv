module top_module(
    input clk,
    input d,
    output reg q);

    reg q_reg;
    reg q_reg2;
    
    always @(posedge clk) begin
        q_reg <= d;
        q_reg2 <= q_reg;
    end

    always @(negedge clk) begin
        q <= q_reg2;
    end

endmodule
