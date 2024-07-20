module top_module (
  input [6:1] y,
  input w,
  output wire Y2,
  output wire Y4
);

  // State set flip flops
  reg [5:0] state;

  always @(posedge w) begin
    case (state)
      6'b000001: state <= 6'b000010; // A -> B
      6'b000010: state <= 6'b000001; // A -> A
      6'b000100: state <= 6'b001000; // B -> C
      6'b001000: state <= 6'b010000; // C -> E
      6'b010000: state <= 6'b100000; // E -> D
      6'b100000: state <= 6'b001000; // D -> F
      default: state <= 6'b000001; // Reset to A
    endcase
  end

  // Output logic
  always @* begin
    Y2 = (state == 6'b001000);
    Y4 = (state == 6'b000100);
  end

endmodule
