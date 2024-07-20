module top_module (
  input [7:0] in,
  output reg [2:0] pos
);
  always @(in) begin
    pos <= 3'd0;
    casez(in)
      8'bzzzzzzz1: pos <= 3'd0;
      8'bz1zzzzzz: pos <= 3'd6;
      // Add more cases here if needed
      default: pos <= 3'd0;
    endcase
  end
endmodule
