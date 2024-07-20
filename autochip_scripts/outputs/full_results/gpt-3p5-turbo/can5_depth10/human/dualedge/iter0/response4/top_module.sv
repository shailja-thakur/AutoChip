module top_module(
    input clk,
    input d,
    output reg q);

    reg q_reg1, q_reg2;
    always @(posedge clk)
    begin
        q_reg1 <= d;
        q_reg2 <= q_reg1;
    end

    always @(posedge clk)
    begin
        q <= q_reg2;
    end

endmodule
