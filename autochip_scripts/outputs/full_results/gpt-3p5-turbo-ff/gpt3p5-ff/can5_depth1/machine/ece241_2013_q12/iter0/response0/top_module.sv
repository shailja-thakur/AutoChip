module top_module (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg [7:0] q,
  output reg Z
);

  always @(posedge clk) begin
    if (enable) begin
      q <= q << 1; // Shifting the register left by 1 bit
      q[0] <= S; // Assigning S to the rightmost bit of the register
    end
  end

  always @(A or B or C) begin
    case ({A, B, C}) // Combining A, B, and C to form a 3-bit address
      3'b000: Z <= q[0]; // Outputting the selected bit of the register on Z
      3'b001: Z <= q[1];
      3'b010: Z <= q[2];
      3'b011: Z <= q[3];
      3'b100: Z <= q[4];
      3'b101: Z <= q[5];
      3'b110: Z <= q[6];
      3'b111: Z <= q[7];
      default: Z <= 1'b0; // Default case
    endcase
  end

endmodule
