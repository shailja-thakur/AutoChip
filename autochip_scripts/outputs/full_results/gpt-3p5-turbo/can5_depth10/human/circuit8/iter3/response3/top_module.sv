module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg [2:0] state;

always @(posedge clock) begin
  case (state)
    3'b000: begin
      if (a == 1'b1) begin
        state <= 3'b001;
      end else begin
        state <= 3'b000;
      end
    end
    3'b001: begin
      p <= 1'b1;
      q <= 1'b1;
      state <= 3'b010;
    end
    3'b010: begin
      if (a == 1'b1) begin
        state <= 3'b011;
      end else begin
        state <= 3'b000;
      end
    end
    3'b011: begin
      p <= 1'b1;
      q <= 1'b0;
      state <= 3'b100;
    end
    3'b100: begin
      if (a == 1'b1) begin
        state <= 3'b101;
      end else begin
        state <= 3'b000;
      end
    end
    3'b101: begin
      p <= 1'b0;
      q <= 1'b0;
      state <= 3'b110;
    end
    3'b110: begin
      if (a == 1'b1) begin
        state <= 3'b111;
      end else begin
        state <= 3'b000;
      end
    end
    3'b111: begin
      p <= 1'b0;
      q <= 1'b1;
      state <= 3'b000;
    end
  endcase
end

endmodule
