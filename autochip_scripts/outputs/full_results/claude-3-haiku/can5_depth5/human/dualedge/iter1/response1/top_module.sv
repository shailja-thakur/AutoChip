module top_module(
    input clk,
    input d,
    output reg q
);

    always @(posedge clk or negedge clk) begin
        q <= d;
    end

endmodule
