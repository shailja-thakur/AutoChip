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
    reg walk_left_reg;
    reg walk_right_reg;
    reg aaah_reg;
    reg digging_reg;
    
    parameter IDLE = 0;
    parameter FALLING = 1;
    parameter WALK_LEFT = 2;
    parameter WALK_RIGHT = 3;
    parameter DIGGING = 4;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else begin
            case (state)
                IDLE: begin
                    if (ground == 0)
                        state <= FALLING;
                    else if (bump_left)
                        state <= WALK_RIGHT;
                    else if (bump_right)
                        state <= WALK_LEFT;
                    else if (dig && ground)
                        state <= DIGGING;
                    else
                        state <= WALK_LEFT;
                end
                FALLING: begin
                    if (ground)
                        state <= IDLE;
                    else if (bump_left || bump_right)
                        state <= FALLING;
                    else if (dig && ground != 0)
                        state <= DIGGING;
                end
                WALK_LEFT: begin
                    if (bump_left)
                        state <= WALK_RIGHT;
                    else if (ground == 0)
                        state <= FALLING;
                    else if (dig && ground)
                        state <= DIGGING;
                    else
                        state <= WALK_LEFT;
                end
                WALK_RIGHT: begin
                    if (bump_right)
                        state <= WALK_LEFT;
                    else if (ground == 0)
                        state <= FALLING;
                    else if (dig && ground)
                        state <= DIGGING;
                    else
                        state <= WALK_RIGHT;
                end
                DIGGING: begin
                    if (!ground)
                        state <= FALLING;
                    else if (bump_left)
                        state <= WALK_RIGHT;
                    else if (bump_right)
                        state <= WALK_LEFT;
                    else if (!dig || ground == 0)
                        state <= WALK_LEFT;
                end
                default: state <= IDLE;
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            IDLE: begin
                walk_left_reg <= 1;
                walk_right_reg <= 0;
                aaah_reg <= 0;
                digging_reg <= 0;
            end
            FALLING: begin
                walk_left_reg <= walk_left_reg;
                walk_right_reg <= walk_right_reg;
                aaah_reg <= 1;
                digging_reg <= 0;
            end
            WALK_LEFT: begin
                walk_left_reg <= 1;
                walk_right_reg <= 0;
                aaah_reg <= 0;
                digging_reg <= 0;
            end
            WALK_RIGHT: begin
                walk_left_reg <= 0;
                walk_right_reg <= 1;
                aaah_reg <= 0;
                digging_reg <= 0;
            end
            DIGGING: begin
                walk_left_reg <= 0;
                walk_right_reg <= 0;
                aaah_reg <= 0;
                digging_reg <= 1;
            end
            default: begin
                walk_left_reg <= 1;
                walk_right_reg <= 0;
                aaah_reg <= 0;
                digging_reg <= 0;
            end
        endcase
    end
    
    assign walk_left = walk_left_reg;
    assign walk_right = walk_right_reg;
    assign aaah = aaah_reg;
    assign digging = digging_reg;
    
endmodule
