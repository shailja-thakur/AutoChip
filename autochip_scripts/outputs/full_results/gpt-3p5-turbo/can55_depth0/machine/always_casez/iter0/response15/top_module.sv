module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    
    always @* begin
        casez(in)
            8'b0000_0001: pos <= 3'b000;
            8'b0001_0000: pos <= 3'b001;
            8'b0001_0001: pos <= 3'b010;
            8'b0010_0000: pos <= 3'b011;
            8'b0010_0001: pos <= 3'b100;
            8'bxxxx_xxxx: pos <= 3'b101;
            8'bzzzz_zzzz: pos <= 3'b110;
            default: pos <= 3'b000;
        endcase
    end

endmodule
