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

    reg [4:0] state;
    reg [4:0] next_state;
    
    parameter WALK_LEFT = 5'b00001;
    parameter WALK_RIGHT = 5'b00010;
    parameter FALL = 5'b00100;
    parameter DIG = 5'b01000;
    parameter SPLATTER = 5'b10000;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = state;
        
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (~ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (~ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end
            end
            
            FALL: begin
                if (ground) begin
                    next_state = state;
                end else if (dig) begin
                    next_state = DIG;
                end else if (state_counter >= 20) begin
                    next_state = SPLATTER;
                end
            end
            
            DIG: begin
                if (ground) begin
                    next_state = state;
                end else if (dig) begin
                    next_state = DIG;
                end else if (~ground) begin
                    next_state = FALL;
                end
            end
            
            SPLATTER: begin
                // Do nothing, Lemming is splattered
            end
        endcase
    end
    
    always @(*) begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALL) || (state == SPLATTER);
        digging = (state == DIG);
    end
    
endmodule
