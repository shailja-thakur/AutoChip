module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

always @(posedge clock) begin
    q <= a;
end

always @(posedge clock) begin
    p <= a;
end

endmodule
