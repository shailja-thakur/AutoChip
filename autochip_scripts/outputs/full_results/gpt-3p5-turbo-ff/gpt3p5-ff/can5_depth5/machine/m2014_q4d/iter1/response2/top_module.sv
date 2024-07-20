module top_module (
    input clk,
    input in,
    output reg out
);

always @(posedge clk)
    out <= in ^ out;

initial
begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
end

endmodule
