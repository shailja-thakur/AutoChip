module top_module (
    input d,
    input ena,
    output logic q
);

// D Latch implementation using always block
always @(d or ena)
    if (ena)
        q <= d;
endmodule
