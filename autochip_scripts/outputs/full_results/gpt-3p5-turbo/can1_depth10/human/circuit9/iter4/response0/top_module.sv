module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

  always @(posedge clk or posedge a) begin
    if (a) begin
      case (q)
        3'b100: q <= 3'b101;
        3'b101: q <= 3'b110;
        3'b110: q <= 3'b000;
        default: q <= 3'b000; // Set default value for q when a = 1
      endcase
    end else begin
      case (q)
        3'b000: q <= 3'b001;
        3'b001: q <= 3'b010;
        3'b010: q <= 3'b011;
        3'b011: q <= 3'b100;
        3'b100: q <= 3'b101;
        3'b101: q <= 3'b110;
        3'b110: q <= 3'b000;
        default: q <= 3'b111; // Set default value for q when a = 0
      endcase
    end
  end

endmodule
