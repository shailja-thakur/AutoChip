module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);

    always @(posedge clk) begin
        out_alwaysblock <= a & b;
    end

    assign out_assign = a & b;

endmodule