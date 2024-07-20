module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state;
  
  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: if (w == 1) state <= 3'b001; else state <= 3'b000;
        3'b001: if (w == 1) state <= 3'b010; else state <= 3'b011;
        3'b010: if (w == 1) state <= 3'b100; else state <= 3'b011;
        3'b011: if (w == 1) state <= 3'b111; else state <= 3'b000;
        3'b100: if (w == 1) state <= 3'b100; else state <= 3'b011;
        3'b111: if (w == 1) state <= 3'b010; else state <= 3'b110;
      endcase
    end
  end
  
  assign z = (state == 3'b100) || (state == 3'b110);
  
endmodule
