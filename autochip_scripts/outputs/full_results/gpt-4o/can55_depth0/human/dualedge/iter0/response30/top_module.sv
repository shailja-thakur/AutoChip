module top_module(
    input clk,
    input d,
    output reg q);

    reg d_ff_1, d_ff_2;

    always @(posedge clk) begin
        d_ff_1 <= d;
    end

    always @(negedge clk) begin
        d_ff_2 <= d;
    end

    always @(*) begin
        q = clk ? d_ff_2 : d_ff_1;
    end
endmodule
