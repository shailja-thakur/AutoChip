module top_module( 
    input [31:0] in,
    output [31:0] out );

    //Insert your code here
    // assign out[31:24] = ...;

    assign out[31:24] = in[15:0];
    assign out[23:16] = in[23:16];
    assign out[15:8] = in[31:24];
    assign out[7:0] = in[31:24];

endmodule