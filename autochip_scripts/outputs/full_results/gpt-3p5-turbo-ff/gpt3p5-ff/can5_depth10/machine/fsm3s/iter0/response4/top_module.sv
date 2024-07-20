module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  reg out_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;  // set initial state to A
      out_reg <= 0;    // reset output
    end else begin
      case (state)
        2'b00: begin    // state A
          if (in) begin
            state <= 2'b01;  // change state to B
          end else begin
            state <= 2'b00;  // remain in state A
          end
        end
        2'b01: begin    // state B
          if (in) begin
            state <= 2'b01;  // remain in state B
          end else begin
            state <= 2'b10;  // change state to C
          end
        end
        2'b10: begin    // state C
          if (in) begin
            state <= 2'b11;  // change state to D
          end else begin
            state <= 2'b00;  // change state back to A
          end
        end
        2'b11: begin    // state D
          if (in) begin
            state <= 2'b01;  // change state back to B
          end else begin
            state <= 2'b10;  // change state back to C
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (state == 2'b11) begin  // output is 1 when state is D
      out_reg <= 1;
    end else begin
      out_reg <= 0;
    end
  end

  assign out = out_reg;

endmodule
