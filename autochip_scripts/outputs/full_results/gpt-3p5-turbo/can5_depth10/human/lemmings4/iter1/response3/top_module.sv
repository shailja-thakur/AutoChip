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
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG,
        SPLATTER
    } state_t;
    
    reg [2:0] current_state;
    reg [2:0] next_state;
    
    // Sequential logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Combinational logic
    always @(*) begin
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                end
                walk_left = 1;
                walk_right = 0; // Added
                aaah = 0; // Added
                digging = 0; // Added
            end
            
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                end
                walk_left = 0; // Added
                walk_right = 1;
                aaah = 0; // Added
                digging = 0; // Added
            end
            
            FALL: begin
                if (ground) begin
                    next_state = WALK_LEFT;
                end else if (current_state == FALL && aaah) begin
                    next_state = SPLATTER;
                end
                aaah = !ground;
                walk_left = 0; // Added
                walk_right = 0; // Added
                digging = 0; // Added
            end
            
            DIG: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (!dig) begin
                    next_state = WALK_LEFT;
                end
                digging = 1;
                walk_left = 0; // Added
                walk_right = 0; // Added
                aaah = 0; // Added
            end
            
            SPLATTER: begin
                walk_left = 0; // Added
                walk_right = 0; // Added
                aaah = 0; // Added
                digging = 0; // Added
            end
            
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule
