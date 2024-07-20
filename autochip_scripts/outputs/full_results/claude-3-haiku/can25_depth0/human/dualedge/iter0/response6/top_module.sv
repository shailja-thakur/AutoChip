module top_module(
    input clk,
    input d,
    output reg q
);

    reg d_delayed;

    always @(posedge clk) begin
        d_delayed <= d;
        q <= (d & ~d_delayed) | (~d & d_delayed);
    end

endmodule
