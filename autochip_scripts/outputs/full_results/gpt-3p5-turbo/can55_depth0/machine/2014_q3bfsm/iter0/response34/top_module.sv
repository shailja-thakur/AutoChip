module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 3'b001;
  end else begin
    state <= next_state;
  end
end

always @(state or x) begin
  case (state)
    3'b001: begin
      if (x) begin
        next_state <= 3'b010; // B
      end else begin
        next_state <= 3'b001; // A
      end
    end
    3'b010: begin
      if (x) begin
        next_state <= 3'b101; // E
      end else begin
        next_state <= 3'b010; // B
      end
    end
    3'b011: begin
      if (x) begin
        next_state <= 3'b010; // B
      end else begin
        next_state <= 3'b011; // C
      end
    end
    3'b100: begin
      if (x) begin
        next_state <= 3'b011; // C
      end else begin
        next_state <= 3'b010; // B
      end
    end
    3'b101: begin
      if (x) begin
        next_state <= 3'b111; // E
      end else begin
        next_state <= 3'b100; // D
      end
    end
    3'b110: begin
      if (x) begin
        next_state <= 3'b100; // D
      end else begin
        next_state <= 3'b011; // C
      end
    end
    3'b111: begin
      if (x) begin
        next_state <= 3'b111; // E
      end else begin
        next_state <= 3'b101; // D
      end
    end
    default: begin
      next_state <= 3'b001; // A
    end
  endcase
end

always @(posedge clk) begin
  if (state == 3'b101 || state == 3'b111) begin
    z <= 1;
  end else begin
    z <= 0;
  end
end

endmodule
