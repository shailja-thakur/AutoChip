module top_module (
  input clk,
  input in,
  input reset,
  output out
);
  reg [1:0] state;
  always @(posedge clk, posedge reset)
  begin
    if (reset)
      state <= 2'b10; // B state
    else
    begin
      case(state)
        2'b10: // B state
        begin
          if (in)
            state <= 2'b10; // B state
          else
            state <= 2'b01; // A state
        end
        2'b01: // A state
        begin
          if (in)
            state <= 2'b01; // A state
          else
            state <= 2'b10; // B state
        end
      endcase
    end
  end

  always @(state)
  begin
    if (state == 2'b10) // B state
      out <= 1'b1;
    else // A state
      out <= 1'b0;
  end
endmodule
