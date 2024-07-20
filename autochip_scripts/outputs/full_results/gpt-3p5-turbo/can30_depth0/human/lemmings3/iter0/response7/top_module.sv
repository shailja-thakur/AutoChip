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

    // State definition
    enum {WALK_LEFT, WALK_RIGHT, FALL, DIG} state;
    
    // Registers
    reg next_state;
    
    // Output assignments
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);
    
    // State transition and next state logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        next_state = WALK_RIGHT;
                    end else if (bump_left) begin
                        next_state = WALK_LEFT;
                    end else if (!ground) begin
                        next_state = FALL;
                    end else if (dig) begin
                        next_state = DIG;
                    end
                end

                WALK_RIGHT: begin
                    if (bump_left) begin
                        next_state = WALK_LEFT;
                    end else if (bump_right) begin
                        next_state = WALK_RIGHT;
                    end else if (!ground) begin
                        next_state = FALL;
                    end else if (dig) begin
                        next_state = DIG;
                    end
                end

                FALL: begin
                    if (ground) begin
                        if (state == WALK_LEFT) begin
                            next_state = WALK_LEFT;
                        end else if (state == WALK_RIGHT) begin
                            next_state = WALK_RIGHT;
                        end
                    end else begin
                        next_state = FALL;
                    end
                end

                DIG: begin
                    if (!ground) begin
                        next_state = FALL;
                    end else if (dig) begin
                        next_state = DIG;
                    end else begin
                        if (state == WALK_LEFT) begin
                            next_state = WALK_LEFT;
                        end else if (state == WALK_RIGHT) begin
                            next_state = WALK_RIGHT;
                        end
                    end
                end
            endcase
            state <= next_state;
        end
    end
endmodule
