module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @* begin
        casez(in)
            8'b0000001?: pos = 0;
            8'b000001?: pos = 1;
            8'b00001?: pos = 2;
            8'b0001?: pos = 3;
            8'b001?: pos = 4;
            8'b01?: pos = 5;
            8'b1?: pos = 6;
            default: pos = 7;
        endcase
    end

endmodule
