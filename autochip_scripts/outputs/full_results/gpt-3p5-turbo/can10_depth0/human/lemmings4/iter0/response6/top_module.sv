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

// Define state enum
typedef enum logic [2:0] {
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    SPLATTER,
    DIGGING
} state_t;

// Define state register
reg [2:0] current_state;
reg [2:0] next_state;

// Define internal signals
reg [4:0] fall_counter;

// Define outputs
assign walk_left = (current_state == WALK_LEFT);
assign walk_right = (current_state == WALK_RIGHT);
assign aaah = (current_state == FALL) && (fall_counter > 20);
assign digging = (current_state == DIGGING);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        fall_counter <= 0;
    end else begin
        current_state <= next_state;
        if (current_state == FALL) begin
            fall_counter <= fall_counter + 1;
        end else begin
            fall_counter <= 0;
        end
    end
end

always @* begin
    next_state = current_state;
    case (current_state)
        WALK_LEFT: begin
            if (bump_right) begin
                next_state = WALK_RIGHT;
            end else if (ground == 0) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        WALK_RIGHT: begin
            if (bump_left) begin
                next_state = WALK_LEFT;
            end else if (ground == 0) begin
                next_state = FALL;
            end else if (dig) begin
                next_state = DIGGING;
            end
        end
        FALL: begin
            if (ground) begin
                if (fall_counter > 20) begin
                    next_state = SPLATTER;
                end else begin
                    next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end
            end
        end
        SPLATTER: begin
            next_state = SPLATTER;
        end
        DIGGING: begin
            if (ground == 0) begin
                next_state = FALL;
            end
        end
    endcase
end

endmodule
