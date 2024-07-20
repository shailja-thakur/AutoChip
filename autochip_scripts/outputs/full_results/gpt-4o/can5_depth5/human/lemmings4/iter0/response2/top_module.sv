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

    reg [2:0] state, next_state;
    reg [4:0] fall_counter;  // 5-bit counter to count the number of clock cycles of falling

    // State encoding
    localparam WALK_LEFT  = 3'b000;
    localparam WALK_RIGHT = 3'b001;
    localparam FALL_LEFT  = 3'b010;
    localparam FALL_RIGHT = 3'b011;
    localparam DIG_LEFT   = 3'b100;
    localparam DIG_RIGHT  = 3'b101;
    localparam SPLATTER   = 3'b110;

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = WALK_RIGHT;
            end
            
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WALK_LEFT;
            end
            
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_LEFT;
                end
            end
            
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_RIGHT;
                end
            end
            
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end
            
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            
            SPLATTER: begin
                // Remain in SPLATTER state once entered
                next_state = SPLATTER;
            end
            
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            FALL_LEFT: aaah = 1;
            FALL_RIGHT: aaah = 1;
            DIG_LEFT: digging = 1;
            DIG_RIGHT: digging = 1;
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

    // Fall counter logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            fall_counter <= 0;
        else if ((state == FALL_LEFT || state == FALL_RIGHT) && ground)
            fall_counter <= fall_counter + 1;
        else if (ground || state == SPLATTER)
            fall_counter <= 0;
    end

endmodule
