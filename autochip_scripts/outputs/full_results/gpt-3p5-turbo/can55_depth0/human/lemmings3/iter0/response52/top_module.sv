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

// States
parameter [1:0] IDLE = 2'b00;
parameter [1:0] WALK_LEFT = 2'b01;
parameter [1:0] WALK_RIGHT = 2'b10;

// Current state
reg [1:0] state, next_state;

// Register for previous ground value
reg prev_ground;

// State outputs
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = 0;
assign digging = 0;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        prev_ground <= 1'b1;
    end
    else begin
        state <= next_state;
        prev_ground <= ground;
    end
end

always @* begin
    case (state)
        IDLE: begin
            if (ground == 1'b0) begin
                next_state = IDLE;
                aaah = 1;
            end
            else begin
                if (bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = IDLE;
                end
                else if (bump_left == 1'b1) begin
                    next_state = WALK_RIGHT;
                end
                else if (bump_right == 1'b1) begin
                    next_state = WALK_LEFT;
                end
                else if (dig == 1'b1 && prev_ground == 1'b1) begin
                    next_state = WALK_LEFT;
                    digging = 1;
                end
                else begin
                    next_state = WALK_LEFT;
                end
            end
        end
        WALK_LEFT: begin
            if (dig == 1'b1 && prev_ground == 1'b1) begin
                next_state = WALK_LEFT;
                digging = 1;
            end
            else if (ground == 1'b0) begin
                next_state = IDLE;
                aaah = 1;
            end
            else begin
                if (bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = IDLE;
                end
                else if (bump_left == 1'b1) begin
                    next_state = WALK_RIGHT;
                end
                else if (bump_right == 1'b1) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_LEFT;
                end
            end
        end
        WALK_RIGHT: begin
            if (dig == 1'b1 && prev_ground == 1'b1) begin
                next_state = WALK_RIGHT;
                digging = 1;
            end
            else if (ground == 1'b0) begin
                next_state = IDLE;
                aaah = 1;
            end
            else begin
                if (bump_left == 1'b1 && bump_right == 1'b1) begin
                    next_state = IDLE;
                end
                else if (bump_left == 1'b1) begin
                    next_state = WALK_RIGHT;
                end
                else if (bump_right == 1'b1) begin
                    next_state = WALK_LEFT;
                end
                else begin
                    next_state = WALK_RIGHT;
                end
            end
        end
    endcase
end

endmodule
