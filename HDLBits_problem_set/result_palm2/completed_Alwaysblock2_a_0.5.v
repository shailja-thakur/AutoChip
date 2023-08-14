module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign
);

    always @(posedge clk) begin
        out_assign = a ^ b;
    end

endmodule