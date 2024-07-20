module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    case (1'b1)
        in[0]: pos = 1;
        in[1]: pos = 2;
        in[2]: pos = 3;
        in[3]: pos = 4;
        in[4]: pos = 5;
        in[5]: pos = 6;
        in[6]: pos = 7;
        in[7]: pos = 8;
        default: pos = 0;
    endcase
end

endmodule
