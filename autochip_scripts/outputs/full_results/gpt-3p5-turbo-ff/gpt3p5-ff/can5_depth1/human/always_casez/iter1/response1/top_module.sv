module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

always @(in) begin
  case (1'b1)

    in[0]: pos <= 3'b0;
    in[1]: pos <= 3'b1;
    in[2]: pos <= 3'b2;
    in[3]: pos <= 3'b3;
    in[4]: pos <= 3'b4;
    in[5]: pos <= 3'b5;
    in[6]: pos <= 3'b6;
    in[7]: pos <= 3'b7;
    default: pos <= 3'b0;
    
  endcase
end

endmodule
