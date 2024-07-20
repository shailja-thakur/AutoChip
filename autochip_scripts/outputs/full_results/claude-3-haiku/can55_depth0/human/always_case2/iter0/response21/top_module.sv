module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1???:  pos = 2'b11;
        4'b01??:  pos = 2'b10;
        4'b001?:  pos = 2'b01;
        4'b0001:  pos = 2'b00;
        default: pos = 2'b00; // if none of the input bits are high, output 0
    endcase
end

endmodule
