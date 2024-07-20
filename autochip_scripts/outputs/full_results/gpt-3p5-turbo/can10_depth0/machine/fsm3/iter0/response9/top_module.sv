module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state; // 2-bit state register
  
  always @(posedge clk) begin
    if (areset) begin
      state <= 2'b00; // reset state to A
    end else begin
      case (state)
        2'b00: state <= (in == 1) ? 2'b01 : 2'b00; // A -> B if input is 1, else A
        2'b01: state <= (in == 1) ? 2'b01 : 2'b10; // B -> B if input is 1, else C
        2'b10: state <= (in == 1) ? 2'b11 : 2'b00; // C -> D if input is 1, else A
        2'b11: state <= (in == 1) ? 2'b01 : 2'b10; // D -> B if input is 1, else C
      endcase
    end
  end

  assign out = (state == 2'b11) ? 1'b1 : 1'b0; // out is 1 when state is D

endmodule
