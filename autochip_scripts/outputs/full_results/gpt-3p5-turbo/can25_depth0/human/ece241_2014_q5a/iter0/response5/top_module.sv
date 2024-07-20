module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  reg [1:0] state;
  reg signed [31:0] sum;
  reg signed [31:0] result;
  reg signed [31:0] twos_comp;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin
          sum <= 0;
          result <= 0;
          twos_comp <= 0;
          state <= 2'b01;
        end
        2'b01: begin
          sum <= sum + x;
          result <= sum;
          twos_comp <= -sum;
          state <= 2'b11;
        end
        2'b10: begin
          sum <= 0;
          result <= 0;
          twos_comp <= 0;
          state <= 2'b00;
        end
        2'b11: begin
          sum <= sum + x;
          result <= sum;
          twos_comp <= -sum;
          if (areset)
            state <= 2'b10;
          else if (x == 1'b1)
            state <= 2'b00;
          else
            state <= 2'b11;
        end
      endcase
    end
  end
  
  assign z = twos_comp;
  
endmodule
