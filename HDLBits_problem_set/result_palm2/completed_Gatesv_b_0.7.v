module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );

    wire [3:0] in_wrapped;
    assign in_wrapped[0] = in[3];
    assign in_wrapped[1] = in[2];
    assign in_wrapped[2] = in[1];
    assign in_wrapped[3] = in[0];

    assign out_both = (in & in_wrapped);
    assign out_any = (in | in_wrapped);
    assign out_different = (~(in ^ in_wrapped));

endmodule