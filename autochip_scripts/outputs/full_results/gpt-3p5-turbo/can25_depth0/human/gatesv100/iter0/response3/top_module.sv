module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    wire [99:0] in_wrapped;

    assign in_shifted[0] = in[99];
    assign in_shifted[1:99] = in[0:98];
    
    assign in_wrapped = {in[99], in};
    
    assign out_both = in[98:0] & in_shifted[98:0];
    assign out_any[99:1] = in[99:1] | in_shifted[99:1];
    assign out_any[0] = 0;
    assign out_different = in[98:0] != in_shifted[98:0] | (in[99] != in[0]) ? in_wrapped[98:0] != in_shifted[98:0] : in[98:0] != in_shifted[98:0];
    
endmodule
