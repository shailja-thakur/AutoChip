module top_module(
    input clk,
    input d,
    output reg q
);

    always @(posedge clk, negedge clk) begin
        if (clk)
            q <= d;
    end

endmodule
