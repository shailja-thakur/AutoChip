module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 3'b000;
  else begin
    case (state)
      3'b000: begin // state A
        if (w)
          state <= 3'b000;
        else
          state <= 3'b001;
      end
      3'b001: begin // state B
        if (w)
          state <= 3'b011;
        else
          state <= 3'b010;
      end
      3'b010: begin // state C
        if (w)
          state <= 3'b101;
        else
          state <= 3'b010;
      end
      3'b011: begin // state D
        if (w)
          state <= 3'b111;
        else
          state <= 3'b000;
      end
      3'b100: begin // state E, output 1
        if (w)
          state <= 3'b100;
        else
          state <= 3'b011;
      end
      3'b101: begin // state F, output 1
        if (w)
          state <= 3'b010;
        else
          state <= 3'b011;
      end
      3'b110: begin // state G, output 0
        if (w)
          state <= 3'b010;
        else
          state <= 3'b011;
      end
      default: state <= 3'b000;
    endcase
  end
end

always @(posedge clk) begin
  case (state)
    3'b000: z <= 1'b0; // state A
    3'b001: z <= 1'b0; // state B
    3'b010: z <= 1'b0; // state C
    3'b011: z <= 1'b0; // state D
    3'b100: z <= 1'b1; // state E
    3'b101: z <= 1'b1; // state F
    3'b110: z <= 1'b0; // state G
    default: z <= 1'b0;
  endcase
end

endmodule
