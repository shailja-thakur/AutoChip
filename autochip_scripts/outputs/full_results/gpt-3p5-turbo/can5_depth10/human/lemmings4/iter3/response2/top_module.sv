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
    typedef enum logic [3:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        SPLATTER
    } state_t;
    
    reg [3:0] current_state;
    reg [3:0] next_state;
    reg [4:0] fall_counter;
    reg [3:0] last_state;
    
    // Sequential logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL && ground) begin
                fall_counter <= 0;
            end else if (current_state == FALL && !ground) begin
                fall_counter <= fall_counter + 1;
            end
        end
    end
    
    // Combinational logic
    always @(*) begin
        next_state = current_state;
        last_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (current_state)
            WALK_LEFT: begin
                if (fall_counter >= 20) begin
                    next_state = SPLATTER;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                end
                walk_left = 1;
                walk_right = 0;
            end
            
            WALK_RIGHT: begin
                if (fall_counter >= 20) begin
                    next_state = SPLATTER;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                end
                walk_left = 0;
                walk_right = 1;
            end
            
            FALL: begin
                if (fall_counter >= 20) begin
                    next_state = SPLATTER;
                end else if (ground) begin
                    next_state = last_state;
                end
                aaah = !ground;
            end
            
            DIG: begin
                if (fall_counter >= 20) begin
                    next_state = SPLATTER;
                end else if (!ground) begin
                    next_state = FALL;
                end else if (!dig) begin
                    next_state = last_state;
                end
                digging = 1;
            end
            
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

endmodule
