module top_module (
    input clk,
    input in,
    output reg out
);

reg prev_out;

always @(posedge clk)
begin
    prev_out <= out;
    out <= in ^ prev_out;
end

initial
begin
    out <= 0;
    prev_out <= 0;
end

endmodule
