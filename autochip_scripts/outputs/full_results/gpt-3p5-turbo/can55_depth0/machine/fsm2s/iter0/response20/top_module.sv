module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

  reg [1:0] state;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= 2'b00;  // State A
    else
    begin
      case (state)
        2'b00:  // State A
          begin
            if (j)
              state <= 2'b01;  // Transition to State B
            else
              state <= 2'b00;  // Remain in State A
          end
        2'b01:  // State B
          begin
            if (k)
              state <= 2'b00;  // Transition to State A
            else
              state <= 2'b01;  // Remain in State B
          end
      endcase
    end
  end

  assign out = (state == 2'b01);  // Output high when state is B, low when state is A

endmodule
