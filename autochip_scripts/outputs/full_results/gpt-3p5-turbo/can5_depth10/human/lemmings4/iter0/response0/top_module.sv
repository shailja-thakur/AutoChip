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
    reg [4:0] fall_counter;

    // State definitions
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;
            fall_counter <= (fall_counter >= 20) ? fall_counter : fall_counter + 1;
        end
    end

    always @(state or bump_left or bump_right or ground or dig) begin
        next_state = state;
        aaah = 0;
        digging = 0;

        case (state)
            
            WALK_LEFT: begin
                if (ground == 0) begin
                    walk_left = 0;
                    walk_right = 0;
                    next_state = FALL;
                end else if (bump_right == 1) begin
                    walk_left = 0;
                    walk_right = 1;
                    next_state = WALK_RIGHT;
                end else if (dig == 1 && ground == 1) begin
                    walk_left = 1;
                    walk_right = 0;
                    next_state = DIG;
                    digging = 1;
                end else begin
                    walk_left = 1;
                    walk_right = 0;
                end
            end
            
            WALK_RIGHT: begin
                if (ground == 0) begin
                    walk_left = 0;
                    walk_right = 0;
                    next_state = FALL;
                end else if (bump_left == 1) begin
                    walk_left = 1;
                    walk_right = 0;
                    next_state = WALK_LEFT;
                end else if (dig == 1 && ground == 1) begin
                    walk_left = 0;
                    walk_right = 1;
                    next_state = DIG;
                    digging = 1;
                end else begin
                    walk_left = 0;
                    walk_right = 1;
                end
            end
            
            FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                
                if (ground == 1) begin
                    next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
                end
            end
            
            DIG: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                
                if (ground == 0) begin
                    fall_counter <= 0;
                end else if (fall_counter >= 20) begin
                    fall_counter <= 0;
                    next_state = WALK_LEFT;
                end
            end

        endcase
    end
    
endmodule
