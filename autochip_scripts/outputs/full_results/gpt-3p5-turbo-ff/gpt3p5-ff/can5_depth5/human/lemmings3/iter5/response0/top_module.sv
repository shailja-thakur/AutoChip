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

    reg [2:0] state;
    reg [2:0] next_state;
    reg [3:0] delay;
    
    parameter WALK_LEFT = 3'b001;
    parameter WALK_RIGHT = 3'b010;
    parameter FALL = 3'b011;
    parameter DIG = 3'b100;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
            delay <= 0;
        end else begin
            state <= next_state;
            case (state)
                WALK_LEFT: begin
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    if (bump_left && !bump_right) begin
                        next_state <= WALK_RIGHT;
                    end else if (!ground) begin
                        next_state <= FALL;
                    end else if (delay == 2 && dig) begin
                        next_state <= DIG;
                    end else begin
                        next_state <= WALK_LEFT;
                    end
                end
                WALK_RIGHT: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    if (bump_right && !bump_left) begin
                        next_state <= WALK_LEFT;
                    end else if (!ground) begin
                        next_state <= FALL;
                    end else if (delay == 2 && dig) begin
                        next_state <= DIG;
                    end else begin
                        next_state <= WALK_RIGHT;
                    end
                end
                FALL: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                    if (ground) begin
                        if (state == WALK_LEFT) begin
                            next_state <= WALK_LEFT;
                        end else if (state == WALK_RIGHT) begin
                            next_state <= WALK_RIGHT;
                        end
                    end else if (delay == 1 && dig) begin
                        next_state <= DIG;
                    end else begin
                        if (bump_left && !bump_right) begin
                            next_state <= WALK_RIGHT;
                        end else if (bump_right && !bump_left) begin
                            next_state <= WALK_LEFT;
                        end else begin
                            next_state <= FALL;
                        end
                    end
                end
                DIG: begin
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;
                    if (!ground) begin
                        next_state <= FALL;
                    end else if (delay == 2 && dig) begin
                        next_state <= DIG;
                    end else begin
                        next_state <= WALK_RIGHT;
                    end
                end
            endcase
        end
        if (delay < 3) begin
            delay <= delay + 1;
        end
    end
endmodule
