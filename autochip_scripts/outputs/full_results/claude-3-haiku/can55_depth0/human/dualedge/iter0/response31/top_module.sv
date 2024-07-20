module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_neg;

    always @(posedge clk) begin
        q <= d;
        q_neg <= ~d;
    end

    always @(negedge clk) begin
        q <= q_neg;
    end

endmodule
