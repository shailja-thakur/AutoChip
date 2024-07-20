module top_module (
  input [2:0] a, 
  output reg [15:0] q
);

always @* begin
  case(a)
    3'd0: q = 16'd4658;
    3'd1: q = 16'd44768;
    3'd2: q = 16'd10196;
    3'd3: q = 16'd23054;
    3'd4: q = 16'd8294;
    3'd5: q = 16'd25806;
    3'd6: q = 16'd50470;
    3'd7: q = 16'd12057;
    default: q = 16'd0;
  endcase
end

endmodule
