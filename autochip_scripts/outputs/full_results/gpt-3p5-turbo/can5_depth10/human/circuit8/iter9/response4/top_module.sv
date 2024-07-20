module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg [1:0] state;

always @(posedge clock) begin
  case (state)
    2'b00: begin
      p <= 1'b0;
      q <= 1'b0;
      if (a == 1'b1) begin
        state <= 2'b01;
      end
    end
    2'b01: begin
      p <= p;
      q <= q;
      if (a == 1'b0) begin
        state <= 2'b10;
      end
    end
    2'b10: begin
      p <= 1'b1;
      q <= 1'b0;
      state <= 2'b00;
    end
  endcase
end

endmodule
