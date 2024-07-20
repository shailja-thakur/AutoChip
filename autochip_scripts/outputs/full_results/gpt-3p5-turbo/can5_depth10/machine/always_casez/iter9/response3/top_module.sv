module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    casez(in)
        8'b1zzzzzzz: pos = 3'b000;
        8'b0zzzzzzzz: pos = 3'b001;
        8'bz1zzzzzz: pos = 3'b010;
        8'bz0zzzzzz: pos = 3'b011;
        8'bz1zzzzzz: pos = 3'b100;
        8'bz0zzzzzz: pos = 3'b101;
        8'bz1zzzzzz: pos = 3'b110;
        8'bz0zzzzzz: pos = 3'b111;
        default: pos = 3'b000;
    endcase
end

endmodule
