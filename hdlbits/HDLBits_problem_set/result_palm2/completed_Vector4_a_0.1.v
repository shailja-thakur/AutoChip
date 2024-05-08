module top_module (
    input [7:0] in,
    output [31:0] out );

    assign out = { 24'b1, in };

endmodule