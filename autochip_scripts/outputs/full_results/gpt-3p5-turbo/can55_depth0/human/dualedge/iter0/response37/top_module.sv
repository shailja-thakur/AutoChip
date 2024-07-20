module top_module(
    input clk,
    input d,
    output reg q);

always @(posedge clk)
begin
    q <= d; // first flip-flop triggered on posedge
end

always @(negedge clk)
begin
    q <= q; // second flip-flop triggered on negedge
end

endmodule
