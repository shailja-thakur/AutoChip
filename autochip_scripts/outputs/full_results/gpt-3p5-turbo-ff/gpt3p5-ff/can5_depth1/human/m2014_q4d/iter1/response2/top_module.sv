module top_module (
    input clk,
    input in,
    output reg out
);

    reg d;
    reg q;

    always @(posedge clk) begin
        d = in ^ q;
        q <= d;
    end

    always @(posedge clk) begin
        out <= q;
    end

endmodule
