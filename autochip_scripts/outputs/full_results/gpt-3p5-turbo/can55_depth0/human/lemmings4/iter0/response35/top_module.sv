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

parameter IDLE = 0;
parameter FALLING = 1;
parameter WALK_LEFT = 2;
parameter WALK_RIGHT = 3;
parameter DIGGING = 4;
parameter SPLATTERED = 5;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case(state)
            IDLE: begin
                if (ground == 0) begin
                    state <= FALLING;
                end else if (bump_left) begin
                    state <= WALK_RIGHT;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                end else if (dig && ground) begin
                    state <= DIGGING;
                end else begin
                    state <= IDLE;
                end
            end
            
            FALLING: begin
                if (ground == 1) begin
                    state <= (state == FALLING) ? WALK_LEFT : WALK_RIGHT;
                end else if (bump_left) begin
                    state <= WALK_RIGHT;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                end else if (dig && ground) begin
                    state <= DIGGING;
                end else begin
                    state <= FALLING;
                end
            end
            
            WALK_LEFT: begin
                if (ground == 0) begin
                    state <= FALLING;
                end else if (bump_left) begin
                    state <= WALK_RIGHT;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                end else if (dig && ground) begin
                    state <= DIGGING;
                end else begin
                    state <= WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (ground == 0) begin
                    state <= FALLING;
                end else if (bump_left) begin
                    state <= WALK_RIGHT;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                end else if (dig && ground) begin
                    state <= DIGGING;
                end else begin
                    state <= WALK_RIGHT;
                end
            end
            
            DIGGING: begin
                if (ground == 0) begin
                    state <= FALLING;
                end else if (bump_left) begin
                    state <= WALK_RIGHT;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                end else begin
                    state <= DIGGING;
                end
            end
            
            SPLATTERED: begin
                state <= SPLATTERED;
            end
        endcase
    end
end

always @(state) begin
    case(state)
        IDLE: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        
        FALLING: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
        end
        
        WALK_LEFT: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        
        WALK_RIGHT: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
        end
        
        DIGGING: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
        end
        
        SPLATTERED: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
    endcase
end

endmodule
