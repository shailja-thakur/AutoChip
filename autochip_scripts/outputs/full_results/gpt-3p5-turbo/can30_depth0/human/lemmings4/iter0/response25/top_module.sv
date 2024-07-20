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
    reg [4:0] next_state;
    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;
    reg [4:0] fall_count;

    parameter WALK_LEFT = 4'b00001;
    parameter WALK_RIGHT = 4'b00010;
    parameter FALLING = 4'b00100;
    parameter DIGGING = 4'b01000;
    parameter SPLATTER = 4'b10000;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            fall_count <= (ground == 1) ? 0 : (fall_count + 1);
        end
    end

    always @* begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                if (bump_right == 1) begin
                    next_state = WALK_RIGHT;
                end else if (dig == 1 && ground == 1) begin
                    next_state = DIGGING;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
                if (bump_left == 1) begin
                    next_state = WALK_LEFT;
                end else if (dig == 1 && ground == 1) begin
                    next_state = DIGGING;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALLING: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
                if (ground == 1) begin
                    if (fall_count > 20) begin
                        next_state = SPLATTER;
                    end else begin
                        if (state == WALK_LEFT) begin
                            next_state = WALK_LEFT;
                        end else begin
                            next_state = WALK_RIGHT;
                        end
                    end
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
                end else begin
                    next_state = DIGGING;
                end
            end

            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                next_state = SPLATTER;
            end
        endcase
    end

endmodule
