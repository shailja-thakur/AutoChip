module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

  reg [3:0] state;  // state variable

  always @(posedge clk) begin
    if (reset) begin
      state <= 0;  // reset
      start_shifting <= 0;
    end else begin
      case (state)
        0: begin  // initial state
          if (data == 1)
            state <= 1;
        end
        1: begin  // searching for '1'
          if (data == 1)
            state <= 2;
          else
            state <= 0;
        end
        2: begin  // searching for '1' followed by '1'
          if (data == 1)
            state <= 3;
          else
            state <= 0;
        end
        3: begin  // searching for '1' followed by '1' followed by '0'
          if (data == 0) begin
            state <= 4;
            start_shifting <= 1;  // enable shifting
          end else
            state <= 0;
        end
        4: begin  // sequence found
          start_shifting <= 1;  // continue shifting
        end
      endcase
    end
  end

endmodule
