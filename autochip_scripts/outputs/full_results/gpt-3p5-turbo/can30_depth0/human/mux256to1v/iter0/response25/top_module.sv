module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [7:0] index;

always @* begin
    case (sel)
        0: index = 0;
        1: index = 4;
        2: index = 8;
        // and so on for all the cases
    endcase
end

assign out = in[index +: 4];

endmodule
