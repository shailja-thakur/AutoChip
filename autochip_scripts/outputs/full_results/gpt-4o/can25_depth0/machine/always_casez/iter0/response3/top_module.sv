module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    casez (in)
        8'bzzzzzzz1: pos = 3'h0;
        8'bzzzzzz10: pos = 3'h1;
        8'bzzzzz100: pos = 3'h2;
        8'bzzzz1000: pos = 3'h3;
        8'bzzz10000: pos = 3'h4;
        8'bzz100000: pos = 3'h5;
        8'bz1000000: pos = 3'h6;
        8'b10000000: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
