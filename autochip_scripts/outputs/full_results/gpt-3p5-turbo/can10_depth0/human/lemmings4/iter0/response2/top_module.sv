module top_module (
  input clk,
  input areset,
  input bump_left,
  input bump_right,
  input ground,
  input dig,
  output reg walk_left,
  output reg walk_right,
  output reg aaah,
  output reg digging
);
  
  reg [4:0] state; // state register

  // assign initial values to outputs
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end
  end

  // state transition logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 0;
    end else begin
      case (state)
        0: begin // walking left
          if (bump_right) begin
            state <= 1;
          end else if (bump_left & ~bump_right) begin
            state <= 2;
          end else if (dig & ground) begin
            state <= 3;
          else if (!ground) begin
            state <= 4;
          end
        end
        1: begin // walking right
          if (bump_left) begin
            state <= 0;
          end else if (bump_right & ~bump_left) begin
            state <= 2;
          end else if (dig & ground) begin
            state <= 3;
          else if (!ground) begin
            state <= 4;
          end
        end
        2: begin // bumped on both sides
          state <= 0;
        end
        3: begin // digging
          if (!dig | !ground) begin
            state <= 4;
          end
        end
        4: begin // falling
          if (!ground) begin
            state <= 4;
          end else begin
            state <= 0;
          end
        end
      endcase
    end
  end
  
  // output logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      walk_left <= 1;
      walk_right <= 0;
      aaah <= 0;
      digging <= 0;
    end else begin
      case (state)
        0: begin
          walk_left <= 1;
          walk_right <= 0;
          aaah <= 0;
          digging <= 0;
        end
        1: begin
          walk_left <= 0;
          walk_right <= 1;
          aaah <= 0;
          digging <= 0;
        end
        2: begin
          walk_left <= 1;
          walk_right <= 1;
          aaah <= 0;
          digging <= 0;
        end
        3: begin
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 0;
          digging <= 1;
        end
        4: begin
          walk_left <= 0;
          walk_right <= 0;
          aaah <= 1;
          digging <= 0;
        end
      endcase
    end
  end

endmodule
