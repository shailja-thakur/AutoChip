module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  reg [1:0] state;
  reg [2:0] next_state;
  
  parameter STATE_0 = 2'b00;
  parameter STATE_1 = 2'b01;
  parameter STATE_2 = 2'b10;

  always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
      state <= STATE_0;
    end else begin
      state <= next_state;
    end
  end
  
  always @(state or x) begin
    next_state = state;
    case (state)
      STATE_0:
        if (x == 1'b1) begin
          next_state = STATE_1;
        end
      STATE_1:
        if (x == 1'b0) begin
          next_state = STATE_2;
        end
      STATE_2:
        if (x == 1'b1) begin
          next_state = STATE_0;
          z <= 1'b1;
        end
      default:
        next_state = STATE_0;
    endcase
  end

endmodule
