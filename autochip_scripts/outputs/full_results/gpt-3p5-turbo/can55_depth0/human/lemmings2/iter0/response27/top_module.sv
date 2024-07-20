module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter RESUME = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or bump_left or bump_right or ground) begin
        aaah = 0;
        walk_left = 0;
        walk_right = 0;
        next_state = state;
        
        case (state)
            WALK_LEFT: begin
                if (bump_left && ~bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (ground) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = FALL;
                end
            end
            WALK_RIGHT: begin
                if (~bump_left && bump_right) begin
                    next_state = WALK_LEFT;
                end else if (ground) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = FALL;
                end
            end
            FALL: begin
                if (ground) begin
                    next_state = RESUME;
                end else begin
                    next_state = FALL;
                end
                aaah = 1;
            end
            RESUME: begin
                if (state == WALK_LEFT) begin
                    next_state = WALK_LEFT;
                end else if (state == WALK_RIGHT) begin
                    next_state = WALK_RIGHT;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
        
        if (next_state == WALK_LEFT) begin
            walk_left = 1;
        end else if (next_state == WALK_RIGHT) begin
            walk_right = 1;
        end
    end
    
endmodule
