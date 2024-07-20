module top_module (
    input clk,
    input a,
    output reg q
);

    always @(posedge clk) begin
        if (a)
            q <= 0;
        else
            q <= 1;
    end

endmodule
