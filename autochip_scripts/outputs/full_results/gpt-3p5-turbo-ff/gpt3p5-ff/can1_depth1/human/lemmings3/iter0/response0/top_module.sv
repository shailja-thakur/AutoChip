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
    wire [1:0] direction;
    reg [1:0] previous_direction;
    
    // Define state values
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    
    // Outputs
    assign walk_left = (direction == WALK_LEFT);
    assign walk_right = (direction == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);
    
    // State transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            direction <= WALK_LEFT;
            previous_direction <= WALK_LEFT;
        end else begin
            state <= next_state;
            direction <= (bump_left && !bump_right) ? WALK_RIGHT :
                        (!bump_left && bump_right) ? WALK_LEFT :
                        (!bump_left && !bump_right && ground) ? direction :
                        direction; // No change in direction
            previous_direction <= direction;
        end
    end
    
    // Next state logic
    always @(state, ground, dig) begin
        case (state)
            WALK_LEFT: begin
                if (dig && !fall && ground) begin
                    next_state = DIG;
                end else if (!fall && !ground) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (dig && !fall && ground) begin
                    next_state = DIG;
                end else if (!fall && !ground) begin
                    next_state = FALL;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL: begin
                if (ground) begin
                    next_state = (previous_direction == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = FALL;
                end
            end
            DIG: begin
                if (ground) begin
                    next_state = (previous_direction == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = DIG;
                end
            end
        endcase
    end

endmodule
