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
    reg [4:0] count;

    parameter IDLE = 5'b00000;
    parameter WALK_LEFT = 5'b00001;
    parameter WALK_RIGHT = 5'b00010;
    parameter FALLING = 5'b00011;
    parameter DIGGING = 5'b00100;

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (areset) begin
                    next_state = WALK_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_LEFT: begin
                if (areset) begin
                    next_state = WALK_LEFT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (areset) begin
                    next_state = WALK_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (areset) begin
                    next_state = WALK_LEFT;
                end else if (ground == 1) begin
                    next_state = state;
                end else begin
                    next_state = FALLING;
                end
            end
            DIGGING: begin
                if (areset) begin
                    next_state = WALK_LEFT;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else begin
                    next_state = DIGGING;
                end
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic
    always @(state) begin
        case(state)
            IDLE: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0; 
            end
            WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0; 
            end
            WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
                digging = 1'b0; 
            end
            FALLING: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b1;
                digging = 1'b0; 
            end
            DIGGING: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b1; 
            end
        endcase
    end

endmodule
