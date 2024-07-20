module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin
          if (in)
            state <= 2'b01;
          else
            state <= 2'b00;
        end

        2'b01: begin
          if (in)
            state <= 2'b01;
          else
            state <= 2'b10;
        end

        2'b10: begin
          if (in)
            state <= 2'b11;
          else
            state <= 2'b01; // Fix: Change to state A instead of C
        end

        2'b11: begin
          if (in)
            state <= 2'b01; // Fix: Change to state B instead of B
          else
            state <= 2'b10;
        end
      endcase
    end
  end

  always @(state) begin
    out = (state == 2'b11);
  end

endmodule
