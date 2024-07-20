module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

always @(posedge clock) begin
    p <= a;
    q <= a;
end

endmodule
