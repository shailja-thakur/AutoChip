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
reg [4:0] next_state;

parameter WALKING_LEFT = 3'b000;
parameter WALKING_RIGHT = 3'b001;
parameter FALLING = 3'b010;
parameter DIGGING = 3'b011;
parameter SPLATTERED = 3'b100;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALKING_LEFT;
    end else begin
        state <= next_state;
    end
end

always @(state or bump_left or bump_right or ground or dig) begin
    case (state)
        WALKING_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = WALKING_RIGHT;
            end else if (ground == 0) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = WALKING_LEFT;
            end
        end
        WALKING_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = WALKING_LEFT;
            end else if (ground == 0) begin
                next_state = FALLING;
            end else if (dig) begin
                next_state = DIGGING;
            end else begin
                next_state = WALKING_RIGHT;
            end
        end
        FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground) begin
                next_state = WALKING_LEFT;
            end else if (bump_left || bump_right) begin
                next_state = FALLING;
            end else begin
                next_state = FALLING;
            end
        end
        DIGGING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (ground == 0) begin
                next_state = FALLING;
            end else if (bump_left || bump_right) begin
                next_state = DIGGING;
            end else begin
                next_state = DIGGING;
            end
        end
        SPLATTERED: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            next_state = SPLATTERED;
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        walk_left <= 0;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            WALKING_LEFT: begin
                walk_left <= 1;
            end
            WALKING_RIGHT: begin
                walk_right <= 1;
            end
            FALLING: begin
                aaah <= 1;
            end
            DIGGING: begin
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
end

endmodule
