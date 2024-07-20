module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  reg [2:0] state;
  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 3'b000;
    else if (w)
      case (state)
        3'b000: state <= 3'b001;
        3'b001: state <= 3'b011;
        3'b010: state <= 3'b110;
        3'b011: state <= 3'b100;
        3'b100: state <= 3'b111;
        3'b101: state <= 3'b101;
        3'b110: state <= 3'b010;
        3'b111: state <= 3'b011;
      endcase
    else
      case (state)
        3'b000: state <= 3'b000;
        3'b001: state <= 3'b001;
        3'b010: state <= 3'b010;
        3'b011: state <= 3'b011;
        3'b100: state <= 3'b100;
        3'b101: state <= 3'b101;
        3'b110: state <= 3'b110;
        3'b111: state <= 3'b111;
      endcase
  end
  
  always @(state) begin
    case (state)
      3'b000: z <= 1'b0;
      3'b001: z <= 1'b0;
      3'b010: z <= 1'b0;
      3'b011: z <= 1'b1;
      3'b100: z <= 1'b1;
      3'b101: z <= 1'b0;
      3'b110: z <= 1'b1;
      3'b111: z <= 1'b1;
    endcase
  end
  
endmodule
