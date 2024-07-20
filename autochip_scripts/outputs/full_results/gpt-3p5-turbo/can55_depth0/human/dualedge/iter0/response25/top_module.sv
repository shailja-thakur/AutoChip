module top_module(
    input clk,
    input d,
    output reg q);

    reg internal_d;

    always @(posedge clk) begin
        internal_d <= d;
    end

    always @(posedge clk) begin
        if (internal_d)
            q <= 1'b1;
        else
            q <= 1'b0;
    end

endmodule
