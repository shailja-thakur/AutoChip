module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    casez(in)
        8'b0000001?: pos <= 3'b000;
        8'b???????1: pos <= 3'b001;
        8'b00000???: pos <= 3'b010;
        8'b0???????: pos <= 3'b011;
        8'b??000000: pos <= 3'b100;
        8'b?000000?: pos <= 3'b101;
        8'b10000000: pos <= 3'b110;
        8'b1???????: pos <= 3'b111;
        default: pos <= 3'b000;
    endcase
end

endmodule
