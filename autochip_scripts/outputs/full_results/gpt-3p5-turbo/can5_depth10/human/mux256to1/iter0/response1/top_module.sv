module top_module (
    input [255:0] in,
    input [7:0] sel,
    output reg out
);

always @(*) begin
    case(sel)
        8'b00000000: out = in[0];
        8'b00000001: out = in[1];
        8'b00000010: out = in[2];
        // ...
        // ...
        // additional cases for in[3], in[4], ..., in[255]
        // ...
        8'b11111111: out = in[255];
    endcase
end
endmodule
