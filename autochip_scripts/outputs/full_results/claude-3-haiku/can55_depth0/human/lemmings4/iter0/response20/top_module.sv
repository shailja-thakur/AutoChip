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

reg [5:0] fall_count; // Counter for number of cycles fallen

// Define the state machine states
localparam STATE_WALK_LEFT = 3'b000;
localparam STATE_WALK_RIGHT = 3'b001;
localparam STATE_FALLING = 3'b010;
localparam STATE_DIGGING = 3'b011;
localparam STATE_SPLATTERED = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
            STATE_FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                fall_count <= fall_count + 1;
            end
            STATE_DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                fall_count <= 0;
            end
            STATE_SPLATTERED: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                fall_count <= 0;
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (ground == 0) begin
                next_state = STATE_FALLING;
            end
            else if (dig == 1) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALK_LEFT;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (ground == 0) begin
                next_state = STATE_FALLING;
            end
            else if (dig == 1) begin
                next_state = STATE_DIGGING;
            end
            else begin
                next_state = STATE_WALK_RIGHT;
            end
        end
        STATE_FALLING: begin
            if (fall_count >= 20 && ground == 1) begin
                next_state = STATE_SPLATTERED;
            end
            else if (ground == 1) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            else begin
                next_state = STATE_FALLING;
            end
        end
        STATE_DIGGING: begin
            if (ground == 0) begin
                next_state = STATE_FALLING;
            end
            else begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_SPLATTERED: begin
            next_state = STATE_SPLATTERED;
        end
        default: begin
            next_state = STATE_WALK_LEFT;
        end
    endcase
end

endmodule
