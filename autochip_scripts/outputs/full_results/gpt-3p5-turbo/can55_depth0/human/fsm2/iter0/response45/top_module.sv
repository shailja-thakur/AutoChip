module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  parameter OFF = 0;
  parameter ON = 1;

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= OFF;
    else
      state <= next_state;
  end

  always @(state, j, k) begin
    case(state)
      OFF: begin
        if (j)
          next_state = ON;
        else
          next_state = OFF;
      end
      
      ON: begin
        if (k)
          next_state = OFF;
        else
          next_state = ON;
      end
    endcase
  end

  always @(state) begin
    case(state)
      OFF: out = 0;
      ON: out = 1;
    endcase
  end

endmodule
