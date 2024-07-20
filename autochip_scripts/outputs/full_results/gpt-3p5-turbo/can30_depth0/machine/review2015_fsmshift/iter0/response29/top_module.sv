module top_module (
  input clk,
  input reset,
  output shift_ena
);

reg [2:0] state;

always @(posedge clk) begin
  if (reset) begin
    state <= 3'b000; // B0
  end else begin
    case (state)
      3'b000 : state <= 3'b001; // B0 to B1
      3'b001 : state <= 3'b010; // B1 to B2
      3'b010 : state <= 3'b011; // B2 to B3
      3'b011 : state <= 3'b100; // B3 to Done
      default : state <= 3'b100; // Any other state to Done
    endcase
  end
end

assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011);

endmodule
