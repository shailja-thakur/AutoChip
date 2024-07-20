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
reg [4:0] next_state;

parameter IDLE = 0;
parameter WALK_LEFT = 1;
parameter WALK_RIGHT = 2;
parameter FALL = 3;
parameter DIG = 4;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(state) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;
    
    case (state)
        IDLE: begin
            if (ground) begin
                next_state = WALK_LEFT;
            end
        end
        
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (!ground) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end
        end
        
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (!ground) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIG;
            end
        end
        
        FALL: begin
            aaah = 1;
            if (ground) begin
                next_state = state; // Stay in the same state
            end
        end
        
        DIG: begin
            digging = 1;
            if (ground) begin
                next_state = WALK_LEFT;
            elseif (!ground && !dig) begin
                next_state = FALL;
            end
        end
    endcase
end

endmodule
