module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  output walk_left,
  output walk_right,
  output aaah
);

  // Define state encoding
  parameter WALK_LEFT = 2'b00;
  parameter WALK_RIGHT = 2'b01;

  // Define state register and next state logic
  reg [1:0] current_state;
  reg [1:0] next_state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= WALK_LEFT;
    end
    else begin
      current_state <= next_state;
    end
  end
  
  // Define output logic
  assign walk_left = (current_state == WALK_LEFT);
  assign walk_right = (current_state == WALK_RIGHT);
  assign aaah = (current_state != WALK_LEFT && current_state != WALK_RIGHT);

  // Define next state logic
  always @* begin
    next_state = current_state;
    case (current_state)
      WALK_LEFT:
        begin
          if (bump_right) begin
            next_state = WALK_RIGHT;
          end
          else if (ground == 0) begin
            next_state = WALK_LEFT;
          end
        end
      WALK_RIGHT:
        begin
          if (bump_left) begin
            next_state = WALK_LEFT;
          end
          else if (ground == 0) begin
            next_state = WALK_RIGHT;
          end
        end
    endcase
  end

endmodule
