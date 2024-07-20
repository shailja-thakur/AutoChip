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

  reg [4:0] state;
  reg [4:0] next_state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 5'b10000;
    end else begin
      state <= next_state;
    end
  end
  
  always @* begin
    case (state)
      5'b10000: begin // walking left state
        if (bump_right & ~bump_left) begin
          next_state = 5'b01000;
        end else if (dig & ground) begin
          next_state = 5'b00100;
        end else if (~ground) begin
          next_state = 5'b00010;
        end else begin
          next_state = 5'b10000;
        end
      end
      5'b01000: begin // walking right state
        if (bump_left & ~bump_right) begin
          next_state = 5'b10000;
        end else if (dig & ground) begin
          next_state = 5'b00100;
        end else if (~ground) begin
          next_state = 5'b00010;
        end else begin
          next_state = 5'b01000;
        end
      end
      5'b00100: begin // digging state
        if (~ground) begin
          next_state = 5'b00010;
        end else begin
          next_state = 5'b00100;
        end
      end
      5'b00010: begin // falling state
        if (ground) begin
          next_state = 5'b10000;
        end else if (state == 5'b00001) begin
          next_state = 5'b00001;
        end else begin
          next_state = state - 1;
        end
      end
      5'b00001: begin // splatter state
        next_state = 5'b00001;
      end
    endcase
  end
  
  always @(state) begin
    case (state)
      5'b10000: begin // walking left state
        walk_left = 1;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
      5'b01000: begin // walking right state
        walk_left = 0;
        walk_right = 1;
        aaah = 0;
        digging = 0;
      end
      5'b00100: begin // digging state
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 1;
      end
      5'b00010: begin // falling state
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
      end
      5'b00001: begin // splatter state
        walk_left = 0;
        walk_right = 0;
        aaah = 1;
        digging = 0;
      end
    endcase
  end
  
endmodule
