module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

// Declare internal logic signals
wire ab_or;
wire cd_or;

// Implement OR gates for a and b, c and d
assign ab_or = a | b;
assign cd_or = c | d;

// Implement the final AND gate for ab_or and cd_or
assign q = ab_or & cd_or;

endmodule
