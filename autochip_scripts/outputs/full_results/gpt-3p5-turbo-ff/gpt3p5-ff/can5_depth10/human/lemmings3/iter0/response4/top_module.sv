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
    parameter WALKING = 2'b01;
    parameter FALLING = 2'b10;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (bump_left && !bump_right)
                        state <= WALKING;
                    else if (!bump_left && bump_right)
                        state <= WALKING;
                    else if (dig && ground)
                        state <= WALKING;
                    else if (!ground)
                        state <= FALLING;
                    else
                        state <= IDLE;
                end
                
                WALKING: begin
                    if (bump_left && !bump_right)
                        state <= WALKING;
                    else if (!bump_left && bump_right)
                        state <= WALKING;
                    else if (!ground)
                        state <= FALLING;
                    else if (dig && ground)
                        state <= WALKING;
                    else
                        state <= IDLE;
                end
                
                FALLING: begin
                    if (ground)
                        state <= WALKING;
                    else
                        state <= FALLING;
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            IDLE: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            
            WALKING: begin
                if (bump_left && !bump_right) begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end else if (!bump_left && bump_right) begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                aaah <= 1'b0;
                digging <= 1'b0;
            end
                
            FALLING: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
            end
        endcase
    end
endmodule
