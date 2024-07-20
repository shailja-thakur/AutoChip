module top_module(
    input clk,
    input d,
    output reg q
);

    reg q_int;

    always @(posedge clk) begin
        q_int <= d;
    end

    always @(negedge clk) begin
        q <= q_int;
    end

endmodule
