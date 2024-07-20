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

    reg [1:0] state;
    reg [1:0] next_state;

    parameter [1:0] WALK_LEFT = 2'b00;
    parameter [1:0] WALK_RIGHT = 2'b01;
    parameter [1:0] FALL = 2'b10;
    parameter [1:0] DIG = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        aaah = 0;
        digging = 0;

        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;

                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                    aaah = 1;
                end
            end

            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;

                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                    aaah = 1;
                end
            end

            FALL: begin
                walk_left = 0;
                walk_right = 0;

                if (ground) begin
                    if (state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end

            DIG: begin
                walk_left = 0;
                walk_right = 0;
                digging = 1;

                if (!ground) begin
                    next_state = FALL;
                    aaah = 1;
                end
            end
        endcase
    end

endmodule
