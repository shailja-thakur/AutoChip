module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg prev_a;

always @(negedge clock) begin
    q <= a;
end

always @(a) begin
    if (clock) begin
        p <= a;
    end
end

endmodule
