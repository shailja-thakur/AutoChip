module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [2:0] state;
  reg [2:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
    end else begin
      state <= next_state;
    end
  end

  always @* begin
    case (state)
      0: begin
        if (data === 1'b1)
          next_state = 1;
        else
          next_state = 0;
      end
      1: begin
        if (data === 1'b1)
          next_state = 2;
        else
          next_state = 0;
      end
      2: begin
        if (data === 1'b1)
          next_state = 2;
        else if (data === 1'b0)
          next_state = 3;
        else
          next_state = 0;
      end
      3: begin
        if (data === 1'b1)
          next_state = 2;
        else if (data === 1'b0)
          next_state = 3;
        else
          next_state = 0;
      end
    endcase
  end

  always @(state) begin
    if (state == 4)
      start_shifting = 1;
    else
      start_shifting = 0;
  end

endmodule
