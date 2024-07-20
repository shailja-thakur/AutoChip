module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

reg a, b;

always @(c, d) begin
    if (c & (~d))
        a = 1;
    else
        a = 0;

    if (~c & d)
        b = 1;
    else
        b = 0;
end

// Implementing the 4-to-1 mux
assign mux_in[0] = (~a & ~b) | (c & ~d);
assign mux_in[1] = (~a & b) | (~c & ~d);
assign mux_in[2] = (a & ~b) | (~c & d);
assign mux_in[3] = (a & b) | (c & d);

endmodule
