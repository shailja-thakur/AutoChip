module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,   // Added "reg" keyword
    output reg out_pos    // Added "reg" keyword
);

  // Create AND gates to detect input conditions
  always @(a, b, c, d) begin   // Added sensitivity list
    case ({a, b, c, d})
      4'b0010, 4'b0111, 4'b1111: out_sop = 1;
      4'b0000, 4'b0001, 4'b0100, 4'b0101,
      4'b0110, 4'b1001, 4'b1010, 4'b1101,
      4'b1110: out_sop = 0;
      default: out_sop = 0;
    endcase
  end

  // Create output equation for out_pos
  always @(a, b, c, d) begin   // Added sensitivity list
    out_pos = ~out_sop;
  end

endmodule
