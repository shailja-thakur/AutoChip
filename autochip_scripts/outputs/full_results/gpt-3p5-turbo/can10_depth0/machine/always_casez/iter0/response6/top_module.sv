module top_module (
   input [7:0] in,
   output reg [2:0] pos
);

always @* begin
    casez(in)
        8'b0000_0001: pos = 3'b0;
        8'b00__00__01: pos = 3'b1;
        8'b00__00__11: pos = 3'b2;
        8'b00__01__01: pos = 3'b3;
        8'b00__01__11: pos = 3'b4;
        8'b00__10__01: pos = 3'b5;
        8'b00__10__11: pos = 3'b6;
        8'b00__11__01: pos = 3'b7;
        8'b00__11__11: pos = 3'b0;

        default: pos = 3'b0;
    endcase
end

endmodule
