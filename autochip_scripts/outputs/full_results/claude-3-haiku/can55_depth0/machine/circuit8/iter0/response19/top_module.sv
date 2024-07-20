module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

// Assign `a` to `q` on the negative edge of `clock`
always @(negedge clock) begin
    q <= a;
end

// Assign `a` to `p` when `clock` is high
always @(a) begin
    if (clock) begin
        p <= a;
    end
end

endmodule
