module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    assign q = (~a & ~b & ~c & d) | (~a & ~b & c) | (~a & b & ~c) | (~a & b & c) | (a & ~b & ~c & d) | (a & ~b & c) | (a & b & c) | (a & b & ~c);

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        $finish;
    end

endmodule
