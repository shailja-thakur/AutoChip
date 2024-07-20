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
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right && !bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (!bump_right && bump_left) begin
                        state <= WALK_LEFT;
                    end else if (bump_right && bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else begin
                        state <= WALK_LEFT;
                    end
                end

                WALK_RIGHT: begin
                    if (bump_right && !bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (!bump_right && bump_left) begin
                        state <= WALK_LEFT;
                    end else if (bump_right && bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else begin
                        state <= WALK_RIGHT;
                    end
                end

                FALL: begin
                    if (ground) begin
                        if (state == WALK_LEFT) begin
                            state <= WALK_LEFT;
                        end else if (state == WALK_RIGHT) begin
                            state <= WALK_RIGHT;
                        end
                    end else begin
                        state <= FALL;
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end

            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end

            FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end

endmodule
