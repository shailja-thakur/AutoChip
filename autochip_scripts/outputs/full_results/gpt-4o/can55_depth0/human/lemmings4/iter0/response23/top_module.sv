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

    // State designations
    typedef enum reg [3:0] {
        LEFT = 4'd0,
        RIGHT = 4'd1,
        FALLING_LEFT = 4'd2,
        FALLING_RIGHT = 4'd3,
        DIG_LEFT = 4'd4,
        DIG_RIGHT = 4'd5,
        SPLATTER = 4'd6
    } state_t;

    state_t current_state, next_state;
    reg [4:0] fall_count;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            current_state <= LEFT;
            fall_count <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING_LEFT || current_state == FALLING_RIGHT) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 5'd0;
            end
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            LEFT: begin
                if (ground == 0) begin
                    next_state = FALLING_LEFT;
                    aaah = 1;
                end else if (dig == 1 && ground == 1) begin
                    next_state = DIG_LEFT;
                    digging = 1;
                end else if (bump_left == 1) begin
                    next_state = RIGHT;
                    walk_right = 1;
                end else begin
                    next_state = LEFT;
                    walk_left = 1;
                end
            end
            RIGHT: begin
                if (ground == 0) begin
                    next_state = FALLING_RIGHT;
                    aaah = 1;
                end else if (dig == 1 && ground == 1) begin
                    next_state = DIG_RIGHT;
                    digging = 1;
                end else if (bump_right == 1) begin
                    next_state = LEFT;
                    walk_left = 1;
                end else begin
                    next_state = RIGHT;
                    walk_right = 1;
                end
            end
            FALLING_LEFT: begin
                aaah = 1;
                if (ground == 1) begin
                    if (fall_count > 20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = LEFT;
                        walk_left = 1;
                    end
                end else begin
                    next_state = FALLING_LEFT;
                end
            end
            FALLING_RIGHT: begin
                aaah = 1;
                if (ground == 1) begin
                    if (fall_count > 20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = RIGHT;
                        walk_right = 1;
                    end
                end else begin
                    next_state = FALLING_RIGHT;
                end
            end
            DIG_LEFT: begin
                digging = 1;
                if (ground == 0) begin
                    next_state = FALLING_LEFT;
                    aaah = 1;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            DIG_RIGHT: begin
                digging = 1;
                if (ground == 0) begin
                    next_state = FALLING_RIGHT;
                    aaah = 1;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER; // Remain in splatter state
            end
        endcase
    end
    
endmodule
