module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output reg [3:1] g
);

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b0;  // Set state to A if reset is low
    else
      state <= next_state;  // Set state to next_state

    case (state)
      2'b00:  // State A
        begin
          if (r[1])  // If r[1] is high, next state is B
            next_state <= 2'b01;
          else if (r[2])  // If r[2] is high, next state is C
            next_state <= 2'b10;
          else if (r[3])  // If r[3] is high, next state is D
            next_state <= 2'b11;
          else  // If none of the bits are high, next state is A
            next_state <= 2'b00;
        end
      2'b01:  // State B
        begin
          if (r[1])  // If r[1] is high, next state is B
            next_state <= 2'b01;
          else  // Otherwise, next state is A
            next_state <= 2'b00;
        end
      2'b10:  // State C
        begin
          if (r[2])  // If r[2] is high, next state is C
            next_state <= 2'b10;
          else  // Otherwise, next state is A
            next_state <= 2'b00;
        end
      2'b11:  // State D
        begin
          if (r[3])  // If r[3] is high, next state is D
            next_state <= 2'b11;
          else  // Otherwise, next state is A
            next_state <= 2'b00;
        end
      default:  // Default case is invalid state, set next state to A
        next_state <= 2'b00;
    endcase
  end
  
  always @(posedge clk) begin
    case (state)
      2'b01:  // State B
        g[1] <= 1'b1;
      2'b10:  // State C
        g[2] <= 1'b1;
      2'b11:  // State D
        g[3] <= 1'b1;
      default:  // Default case, set all bits of g to 0
        g <= 3'b0;
    endcase
  end

endmodule
