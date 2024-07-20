module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  reg [1:0] state;
  reg out;

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: 
          if (j)
            state <= 2'b01;
          else
            state <= 2'b00;
        2'b01:
          if (k)
            state <= 2'b00;
          else
            state <= 2'b01;
      endcase
    end
  end

  always @(state)
  begin
    case (state)
      2'b00: out <= 1'b0;
      2'b01: out <= 1'b1;
    endcase
  end

endmodule
