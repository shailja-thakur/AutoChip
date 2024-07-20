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

  reg [4:0] state;
  reg fall;
  reg [4:0] timer;

  parameter IDLE = 3'b000;
  parameter FALL = 3'b001;
  parameter DIG = 3'b010;
  parameter WALK = 3'b100;
  parameter SPLATTER = 3'b101;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= IDLE;
      fall <= 0;
      timer <= 0;
    end else begin
      case(state)
        IDLE: begin
          if (!ground) begin
            state <= FALL;
            fall <= 1;
          end else if (dig && ground) begin
            state <= DIG;
          end else if (bump_left && !fall) begin
            state <= WALK;
          end else if (bump_right && !fall) begin
            state <= WALK;
          end
        end

        FALL: begin
          if (ground) begin
            state <= IDLE;
            fall <= 0;
          end else if (timer >= 5'd20) begin
            state <= SPLATTER;
          end
        end

        DIG: begin
          if (!ground) begin
            state <= FALL;
            fall <= 1;
          end else if (timer >= 5'd20) begin
            state <= SPLATTER;
          end
        end

        WALK: begin
          if (!ground) begin
            state <= FALL;
            fall <= 1;
          end else if (dig && ground) begin
            state <= DIG;
          end else if (bump_left && !fall) begin
            state <= WALK;
          end else if (bump_right && !fall) begin
            state <= WALK;
          end
        end

        SPLATTER: begin
          state <= SPLATTER;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (areset) begin
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      case(state)
        IDLE: begin
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end

        FALL: begin
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 1;
          digging <= 0;
        end

        DIG: begin
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 1;
        end

        WALK: begin
          if (bump_left) begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
          end else if (bump_right) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
          end else begin
            walk_left <= walk_left;
            walk_right <= walk_right;
            aaah <= 0;
            digging <= 0;
          end
        end

        SPLATTER: begin
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (areset) begin
      timer <= 0;
    end else if (state == FALL || state == DIG) begin
      timer <= timer + 1;
    end else begin
      timer <= 0;
    end
  end

endmodule
