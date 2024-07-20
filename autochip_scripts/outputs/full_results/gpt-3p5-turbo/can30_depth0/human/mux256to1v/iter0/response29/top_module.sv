module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  wire [255:0] in_sel;

  assign in_sel[0] = in[3:0];
  assign in_sel[1] = in[7:4];
  assign in_sel[2] = in[11:8];
  // ... continue assigning in_sel for the remaining 253 bit ranges

  always @ (sel) begin
    case (sel)
      8'b00000000: out <= in_sel[0];
      8'b00000001: out <= in_sel[1];
      8'b00000010: out <= in_sel[2];
      // ... continue with the remaining cases
    endcase
  end

endmodule
