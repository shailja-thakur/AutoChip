module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

  always @*
  begin
    casez(in)
      8'b00000001: pos = 3'b0;
      8'b0000000?: pos = 3'b1;
      8'b000000??: pos = 3'b2;
      8'b00000???: pos = 3'b3;
      8'b0000????: pos = 3'b4;
      8'b000?????: pos = 3'b5;
      8'b00??????: pos = 3'b6;
      8'b0???????: pos = 3'b7;
      8'b????????: pos = 3'b8;
      default: pos = 3'b0;
    endcase
  end

endmodule
