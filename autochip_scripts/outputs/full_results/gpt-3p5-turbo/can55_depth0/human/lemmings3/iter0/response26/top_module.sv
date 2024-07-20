module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output walk_left,
  output walk_right,
  output aaah,
  output digging
);

  // define states
  reg [1:0] state;
  localparam IDLE = 2'b00;
  localparam WALK_LEFT = 2'b01;
  localparam WALK_RIGHT = 2'b10;
  localparam DIGGING = 2'b11;

  // define outputs
  assign walk_left = (state == WALK_LEFT);
  assign walk_right = (state == WALK_RIGHT);
  assign aaah = (state == IDLE) & !ground;
  assign digging = (state == DIGGING);

  // define next state logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= WALK_LEFT;
    end else begin
      case (state)
        IDLE: begin
          if (dig & ground) begin
            state <= DIGGING;
          end else if (!ground) begin
            state <= IDLE;
          end else if (bump_left) begin
            state <= WALK_RIGHT;
          end else if (bump_right) begin
            state <= WALK_LEFT;
          end
        end
        WALK_LEFT: begin
          if (bump_left) begin
            state <= WALK_RIGHT;
          end else if (ground & !dig) begin
            state <= WALK_LEFT;
          end
        end
        WALK_RIGHT: begin
          if (bump_right) begin
            state <= WALK_LEFT;
          end else if (ground & !dig) begin
            state <= WALK_RIGHT;
          end
        end
        DIGGING: begin
          if (!ground) begin
            state <= IDLE;
          end else if (dig & ground) begin
            state <= DIGGING;
          end
        end
      endcase
    end
  end
endmodule
