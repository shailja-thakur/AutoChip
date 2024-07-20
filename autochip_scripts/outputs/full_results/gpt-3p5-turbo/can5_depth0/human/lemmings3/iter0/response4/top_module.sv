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

// Define the states for the finite state machine
localparam IDLE = 2'b00;
localparam WALK = 2'b01;
localparam FALL = 2'b10;
localparam DIG = 2'b11;

// Define the state register
reg [1:0] state;

// Define the outputs
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

// Define the next state and output logic
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= IDLE; // Reset the state to IDLE on asynchronous reset
    walk_left <= 1'b1; // Start walking left on reset
    walk_right <= 1'b0;
    aaah <= 1'b0;
    digging <= 1'b0;
  end else begin
    case (state)
      IDLE:
        if (areset) begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
          state <= IDLE;
        end else if (bump_left || bump_right) begin
          if (bump_left && bump_right) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end else if (bump_left) begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
          end else if (bump_right) begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
          end
          state <= WALK;
        end else if (!ground) begin
          walk_left <= 1'b0;
          walk_right <= 1'b0;
          aaah <= 1'b1;
          digging <= 1'b0;
          state <= FALL;
        end else if (dig) begin
          if (ground) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            state <= DIG;
          end
        end
      
      WALK:
        if (areset) begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
          state <= IDLE;
        end else if (!ground) begin
          walk_left <= 1'b0;
          walk_right <= 1'b0;
          aaah <= 1'b1;
          digging <= 1'b0;
          state <= FALL;
        end else if (dig) begin
          if (ground) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            state <= DIG;
          end
        end
      
      FALL:
        if (areset) begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
          state <= IDLE;
        end else if (ground) begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
          state <= IDLE;
        end
      
      DIG:
        if (areset) begin
          walk_left <= 1'b1;
          walk_right <= 1'b0;
          aaah <= 1'b0;
          digging <= 1'b0;
          state <= IDLE;
        end else if (!ground) begin
          walk_left <= 1'b0;
          walk_right <= 1'b0;
          aaah <= 1'b1;
          digging <= 1'b0;
          state <= FALL;
        end else if (dig) begin
          if (ground) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
            state <= DIG;
          end
        end
    endcase
  end
end

endmodule
