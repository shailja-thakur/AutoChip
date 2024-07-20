module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] inv_signal;
    wire [24:0] direct_signal;

    // Generate the inverted signal vector
    assign inv_signal = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};

    // Generate the direct signal vector
    assign direct_signal = {5{a, b, c, d, e}};

    // Compute the bitwise exclusive-or
    assign out = inv_signal ^ direct_signal;

endmodule
