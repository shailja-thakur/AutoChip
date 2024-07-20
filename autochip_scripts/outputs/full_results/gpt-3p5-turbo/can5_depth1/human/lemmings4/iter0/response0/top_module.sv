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
    
    // Declare the states of the finite state machine
    parameter [3:0] WALK_LEFT = 4'b0001;
    parameter [3:0] WALK_RIGHT = 4'b0010;
    parameter [3:0] FALL = 4'b0100;
    parameter [3:0] DIG = 4'b1000;
    parameter [3:0] SPLATTER = 4'b1001;
    
    // Declare the signals for the state machine
    reg [3:0] current_state;
    reg [3:0] next_state;
    
    // Initialize the current state to WALK_LEFT on reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Declare the outputs of the state machine
    always @(current_state) begin
        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
            FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
            DIG: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
            SPLATTER: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end
    
    // Declare the next state logic based on inputs and current state
    always @(current_state, bump_left, bump_right, ground, dig) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (!bump_left && !ground) begin
                    next_state = FALL;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (dig && !ground) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (!bump_right && !ground) begin
                    next_state = FALL;
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (dig && !ground) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL: begin
                if (ground) begin
                    if (current_state == FALL) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = current_state;
                    end
                end else if (dig && ground) begin
                    next_state = DIG;
                end else if (dig && !ground) begin
                    next_state = FALL;
                end else begin
                    next_state = FALL;
                end
            end
            DIG: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (dig && !ground) begin
                    next_state = FALL;
                end else begin
                    next_state = DIG;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end
endmodule
