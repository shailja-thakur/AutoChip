module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] shifted_in;
    wire [99:0] in_concat;
  
    assign shifted_in = {in[98:0], 1'b0};
    assign in_concat = {in[99], shifted_in};
    
    assign out_both = in[98:0] & shifted_in;
    assign out_any = in[99:0] | in_concat;
    assign out_different = in_concat ^ in;
    
endmodule
