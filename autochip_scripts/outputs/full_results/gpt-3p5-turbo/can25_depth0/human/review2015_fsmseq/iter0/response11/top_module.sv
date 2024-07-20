module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);
  reg [3:0] state;
  reg [3:0] next_state;

  // Correction: Add initial block to set initial values
  initial begin
    state = 0;
    next_state = 0;
    start_shifting = 0;
  end

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;
      start_shifting <= 0;
    end
    else begin
      state <= next_state;
      start_shifting <= 0;

      case (state)
        0: begin
          if (data)
            next_state = 1;
          else
            next_state = 0;
        end
        1: begin
          if (data)
            next_state = 1;
          else
            next_state = 0;
        end
        2: begin
          if (data)
            next_state = 3;
          else
            next_state = 0;
        end
        3: begin
          if (data)
            next_state = 0;
          else
            next_state = 4;
        end
        4: begin
          if (data)
            next_state = 1;
          else
            next_state = 0;
        end
      endcase

      if (state == 3 && next_state == 0)
        start_shifting <= 1;
    end
  end
endmodule
