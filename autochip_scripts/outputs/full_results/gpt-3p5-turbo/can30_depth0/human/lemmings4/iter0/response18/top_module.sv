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
wire bumped = bump_left | bump_right;

parameter WALKING_LEFT = 4'b00001;
parameter WALKING_RIGHT = 4'b00010;
parameter FALLING = 4'b00100;
parameter DIGGING = 4'b01000;
parameter SPLATTERED = 4'b10000;

assign walk_left = (state == WALKING_LEFT);
assign walk_right = (state == WALKING_RIGHT);
assign aaah = (state == FALLING) && ground;
assign digging = (state == DIGGING);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
    end else begin
        case(state)
            WALKING_LEFT: begin
                if (bump_left && !bump_right) begin
                    state <= WALKING_RIGHT;
                end else if (ground && !bump_left && !bump_right) begin
                    state <= WALKING_LEFT;
                end else if (!ground && !bump_left && !bump_right) begin
                    state <= FALLING;
                end else if (dig && ground && !bump_left && !bump_right) begin
                    state <= DIGGING;
                end else if (bump_left && bump_right) begin
                    state <= WALKING_RIGHT;
                end else if (aaah) begin
                    state <= FALLING;
                end else if (bump_left && bump_right && !aaah) begin
                    state <= WALKING_LEFT;
                end
            end
            WALKING_RIGHT: begin
                if (!bump_left && bump_right) begin
                    state <= WALKING_LEFT;
                end else if (ground && !bump_left && !bump_right) begin
                    state <= WALKING_RIGHT;
                end else if (!ground && !bump_left && !bump_right) begin
                    state <= FALLING;
                end else if (dig && ground && !bump_left && !bump_right) begin
                    state <= DIGGING;
                end else if (bump_left && bump_right) begin
                    state <= WALKING_LEFT;
                end else if (aaah) begin
                    state <= FALLING;
                end else if (bump_left && bump_right && !aaah) begin
                    state <= WALKING_RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    if (aaah) begin
                        state <= SPLATTERED;
                    end else begin
                        if (state == WALKING_LEFT) begin
                            state <= WALKING_LEFT;
                        end else if (state == WALKING_RIGHT) begin
                            state <= WALKING_RIGHT;
                        end
                    end
                end else begin
                    state <= FALLING;
                end
            end
            DIGGING: begin
                if (!ground) begin
                    state <= FALLING;
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
        WALKING_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALKING_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        DIGGING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
        SPLATTERED: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

endmodule
