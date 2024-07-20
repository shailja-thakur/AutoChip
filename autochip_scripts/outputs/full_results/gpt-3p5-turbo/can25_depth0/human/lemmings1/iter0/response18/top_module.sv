module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  output reg walk_left,
  output reg walk_right
);

reg [1:0] state;
// define the states
localparam IDLE_STATE = 2'b00;
localparam WALK_LEFT_STATE = 2'b01;
localparam WALK_RIGHT_STATE = 2'b10;

// Moore output function
always @ (posedge clk or posedge areset) begin
  if (areset) begin
    state <= WALK_LEFT_STATE;
  end else begin
    case (state)
      IDLE_STATE:
        begin
          if (bump_left)
            state <= WALK_RIGHT_STATE;
          else if (bump_right)
            state <= WALK_LEFT_STATE;
        end
      WALK_LEFT_STATE:
        begin
          if (bump_left && !bump_right)
            state <= WALK_RIGHT_STATE;
          else if (!bump_left && !bump_right)
            state <= IDLE_STATE;
        end
      WALK_RIGHT_STATE:
        begin
          if (!bump_left && bump_right)
            state <= WALK_LEFT_STATE;
          else if (!bump_left && !bump_right)
            state <= IDLE_STATE;
        end
      default:
        state <= IDLE_STATE;
    endcase
  end
end

// Moore output logic
always @ (state) begin
  case (state)
    IDLE_STATE:
      begin
        walk_left = 1'b1;
        walk_right = 1'b0;
      end
    WALK_LEFT_STATE:
      begin
        walk_left = 1'b1;
        walk_right = 1'b0;
      end
    WALK_RIGHT_STATE:
      begin
        walk_left = 1'b0;
        walk_right = 1'b1;
      end
    default:
      begin
        walk_left = 1'b1;
        walk_right = 1'b0;
      end
  endcase
end

endmodule
