module top_module (
    input clk,
    input in,
    output reg out
);
    always @(posedge clk) begin
        if (in == 1'b1)
            out <= ~out;
    end
endmodule
