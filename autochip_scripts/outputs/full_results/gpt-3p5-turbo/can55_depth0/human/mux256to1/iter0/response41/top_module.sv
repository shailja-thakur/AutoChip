module top_module (
    input [255:0] in,
    input [7:0] sel,
    output reg out
);

always @(*) begin
    case(sel)
        8'b00000000 : out = in[0];
        8'b00000001 : out = in[1];
        8'b00000010 : out = in[2];
        8'b00000011 : out = in[3];
        8'b00000100 : out = in[4];
        8'b00000101 : out = in[5];
        8'b00000110 : out = in[6];
        8'b00000111 : out = in[7];
        8'b00001000 : out = in[8];
        8'b00001001 : out = in[9];
        // Add the remaining cases up to 8'b11111111
        default : out = 0; // Default case if none of the above matches
    endcase
end

endmodule
