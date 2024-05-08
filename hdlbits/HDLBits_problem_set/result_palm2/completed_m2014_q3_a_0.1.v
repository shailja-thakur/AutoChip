module top_module (
    input [4:1] x, 
    output f );

    wire [4:1] sel;
    wire [1:0] or_out;

    assign sel = x[3:2];
    assign or_out = x[1:0] | x[3:2];

    assign f = or_out;

endmodule