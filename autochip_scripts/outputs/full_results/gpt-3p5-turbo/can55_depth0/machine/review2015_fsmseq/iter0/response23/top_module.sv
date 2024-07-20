module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

  reg [3:0] state, next_state;

  always @(posedge clk) begin
    if (reset)
      state <= 4'd0;
    else
      state <= next_state;
  end

  always @(*) begin
    case (state)
      4'd0: begin
        if (data)
          next_state = 4'd1;
        else
          next_state = 4'd0;
      end
      4'd1: begin
        if (data)
          next_state = 4'd3;
        else
          next_state = 4'd0;
      end
      4'd3: begin
        if (data)
          next_state = 4'd3;
        else
          next_state = 4'd6;
      end
      4'd6: begin
        if (data)
          next_state = 4'd7;
        else
          next_state = 4'd0;
      end
      4'd7: begin
        next_state = 4'd7;
      end
    endcase
  end

  assign start_shifting = (state == 4'd7);

endmodule
