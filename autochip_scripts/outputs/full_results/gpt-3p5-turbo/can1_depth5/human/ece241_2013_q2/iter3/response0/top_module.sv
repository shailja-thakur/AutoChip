module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

  // Create output equation for out_sop
  always @* begin
    case ({a, b, c, d})
      4'b0010, 4'b0111, 4'b1111: out_sop = 1;
      default: out_sop = 0;
    endcase
  end

  // Create output equation for out_pos
  always @* begin
    out_pos = ~out_sop;
  end

endmodule
