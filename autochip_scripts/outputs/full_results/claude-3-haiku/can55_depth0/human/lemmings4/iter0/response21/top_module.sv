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

// Define the states
localparam [1:0] LEFT = 2'b00, RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;

// State register
reg [1:0] state, next_state;

// Falltime counter
reg [4:0] falltime;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        falltime <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == LEFT);
        walk_right <= (state == RIGHT);
        aaah <= (state == FALL);
        digging <= (state == DIG);
        if (state == FALL) begin
            falltime <= falltime + 1;
        end
        else begin
            falltime <= 0;
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        LEFT: begin
            if (bump_right) begin
                next_state = RIGHT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig && ground) begin
                next_state = DIG;
            end
        end
        RIGHT: begin
            if (bump_left) begin
                next_state = LEFT;
            end
            else if (!ground) begin
                next_state = FALL;
            end
            else if (dig && ground) begin
                next_state = DIG;
            end
        end
        FALL: begin
            if (ground) begin
                if (falltime >= 5'd20) begin
                    next_state = state;
                end
                else begin
                    if (walk_left) begin
                        next_state = LEFT;
                    end
                    else begin
                        next_state = RIGHT;
                    end
                end
            end
        end
        DIG: begin
            if (!ground) begin
                next_state = FALL;
            end
        end
    endcase
end

endmodule
