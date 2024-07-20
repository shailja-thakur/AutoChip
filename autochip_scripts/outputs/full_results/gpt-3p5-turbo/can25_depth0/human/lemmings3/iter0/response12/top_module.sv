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
    reg [1:0] state;
    
    parameter IDLE = 2'b00;
    parameter WALK_LEFT = 2'b01;
    parameter WALK_RIGHT = 2'b10;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case(state)
                
                // IDLE state
                IDLE: begin
                    if (bump_left && !bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!bump_left && bump_right) begin
                        state <= WALK_LEFT;
                    end else if (!bump_left && !bump_right && !ground) begin
                        state <= IDLE;
                    end else if (!bump_left && !bump_right && ground && !dig) begin
                        state <= WALK_RIGHT;
                    end else if (!bump_left && !bump_right && ground && dig) begin
                        state <= IDLE;
                    end
                end
                
                // WALK_LEFT state
                WALK_LEFT: begin
                    if (!bump_left && bump_right) begin
                        state <= WALK_LEFT;
                    end else if (!bump_left && !bump_right && !ground) begin
                        state <= IDLE;
                    end else if (!bump_left && !bump_right && ground && !dig) begin
                        state <= WALK_LEFT;
                    end else if (!bump_left && !bump_right && ground && dig) begin
                        state <= IDLE;
                    end
                end
                
                // WALK_RIGHT state
                WALK_RIGHT: begin
                    if (bump_left && !bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!bump_left && !bump_right && !ground) begin
                        state <= IDLE;
                    end else if (!bump_left && !bump_right && ground && !dig) begin
                        state <= WALK_RIGHT;
                    end else if (!bump_left && !bump_right && ground && dig) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            IDLE: begin
                walk_left <= 1;
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
        endcase
    end
endmodule
