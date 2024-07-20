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

// Declare the states
localparam STATE_WALK_LEFT = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALL = 2'b10;
localparam STATE_DIG = 2'b11;

// Declare the state register
reg [1:0] state, next_state;

// Declare the walking direction register
reg walking_left;

// Assign the outputs
assign walk_left = (state == STATE_WALK_LEFT);
assign walk_right = (state == STATE_WALK_RIGHT);
assign aaah = (state == STATE_FALL);
assign digging = (state == STATE_DIG);

// State transition logic
always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
                walking_left = 0;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
                walking_left = 1;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                next_state = (walking_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
        STATE_DIG: begin
            if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (!dig) begin
                next_state = (walking_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            end
        end
    endcase
end

// State register update
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walking_left <= 1;
    end
    else begin
        state <= next_state;
    end
end

endmodule
