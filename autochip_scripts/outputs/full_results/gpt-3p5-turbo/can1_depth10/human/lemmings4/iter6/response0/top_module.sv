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
  
  wire falling;
  wire splatter;
  
  wire ready_to_fall;
  wire ready_to_dig;
  
  assign ready_to_fall = (state == 5'b00010 && ground);
  assign ready_to_dig = (state == 5'b00100 && ~falling);
  
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
        if (bump_right && ~falling) begin
          next_state = 5'b01000;
        end else if (ready_to_dig && dig) begin
          next_state = 5'b00100;
        end else if (!ground) begin
          next_state = 5'b00010;
        end else begin
          next_state = 5'b10000;
        end
      end
      5'b01000: begin // walking right state
        if (bump_left && ~falling) begin
          next_state = 5'b10000;
        end else if (ready_to_dig && dig) begin
          next_state = 5'b00100;
        end else if (!ground) begin
          next_state = 5'b00010;
        end else begin
          next_state = 5'b01000;
        end
      end
      5'b00100: begin // digging state
        if (!ground || (bump_left && ~falling) || (bump_right && ~falling)) begin
          next_state = 5'b00010;
        end else begin
          next_state = 5'b00100;
        end
      end
      5'b00010: begin // falling state
        if (ground) begin
          if (falling && splatter) begin
            next_state = 5'b00001;
          end else begin
            next_state = 5'b10000;
          end
        end else if (falling && !ready_to_fall) begin
          next_state = state;
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
  
  fsm_splatter fsm_splatter_inst (
    .clk(clk),
    .reset(areset),
    .ready_to_splatter(state == 5'b00010 && ground),
    .splatter(splatter)
  );
  
  fsm_fall fsm_fall_inst (
    .clk(clk),
    .reset(areset),
    .ready_to_fall(ready_to_fall),
    .falling(falling)
  );
  
endmodule
module fsm_splatter (
  input clk,
  input reset,
  input ready_to_splatter,
  output reg splatter
);
  reg [4:0] count;

  always @(posedge clk) begin
    if (reset) begin
      count <= 0;
      splatter <= 0;
    end else begin
      if (ready_to_splatter) begin
        count <= count + 1;
        if (count >= 20) begin
          splatter <= 1;
        end else begin
          splatter <= 0;
        end
      end else begin
        count <= 0;
        splatter <= 0;
      end
    end
  end
  
endmodule
module fsm_fall (
  input clk,
  input reset,
  input ready_to_fall,
  output reg falling
);
  always @(posedge clk) begin
    if (reset) begin
      falling <= 0;
    end else begin
      if (ready_to_fall) begin
        falling <= 1;
      end else if (~ready_to_fall && falling) begin
        falling <= 0;
      end
    end
  end
  
endmodule
