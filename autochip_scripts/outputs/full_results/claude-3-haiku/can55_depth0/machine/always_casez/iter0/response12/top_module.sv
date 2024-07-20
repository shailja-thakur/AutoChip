module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @(in) begin
    casez (in)
        8'b0000_0001: pos = 3'h0;
        8'b0000_0010: pos = 3'h1;
        8'b0000_0100: pos = 3'h2;
        8'b0000_1000: pos = 3'h3;
        8'b0001_0000: pos = 3'h4;
        8'b0010_0000: pos = 3'h5;
        8'b0100_0000: pos = 3'h6;
        8'b1000_0000: pos = 3'h7;
        default: pos = 3'h0;
    endcase
end

endmodule
