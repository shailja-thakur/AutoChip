module top_module (
    input  [99:0] in,
    output [99:0] out_any,
    output [99:0] out_different,
    output [98:0] out_both
);
    wire [99:0] shifted_in;
    
    assign shifted_in = {in[98:0], 1'b0}; // Shift input by one bit

    assign out_both = in[99:1] & shifted_in[99:1];
    assign out_any = in | shifted_in;
    assign out_different = {in[99] ^ shifted_in[99], in[98:0] ^ shifted_in[99:1]};

endmodule
