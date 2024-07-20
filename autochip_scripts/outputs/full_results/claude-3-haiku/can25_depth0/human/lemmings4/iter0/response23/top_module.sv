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

localparam STATE_WALK_LEFT = 1'b0;
localparam STATE_WALK_RIGHT = 1'b1;

reg [4:0] fall_count;
reg current_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'd0;
    end
    else begin
        current_state <= next_state;
        walk_left <= (current_state == STATE_WALK_LEFT);
        walk_right <= (current_state == STATE_WALK_RIGHT);
        
        if (ground) begin
            fall_count <= 5'd0;
        end
        else begin
            fall_count <= fall_count + 1'b1;
        end
        
        if (fall_count >= 20) begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end
        else begin
            aaah <= ~ground;
            digging <= (current_state == ground);
        end
    end
end

always @(*) begin
    next_state = current_state;
    
    if (bump_left) begin
        next_state = STATE_WALK_RIGHT;
    end
    else if (bump_right) begin
        next_state = STATE_WALK_LEFT;
    end
    else if (~ground) begin
        next_state = current_state;
    end
    else if (dig) begin
        next_state = ground;
    end
end

endmodule
