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
    reg [3:0] last_state;
    reg [3:0] prev_state;
    reg [3:0] fall_counter;
    
    // Sequential logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            prev_state <= current_state;
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
        walk_left = (current_state == WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right = (current_state == WALK_RIGHT) ? 1'b1 : 1'b0;
        aaah = (current_state == FALL || current_state == DIG || current_state == SPLATTER) ? 1'b1 : 1'b0;
        digging = (current_state == DIG) ? 1'b1 : 1'b0;
        
        case (current_state)
            WALK_LEFT: begin
                if ((fall_counter > 20 && ground) || (!ground && bump_right) || bump_left) begin
                    next_state = WALK_RIGHT;
                end else if (dig && ground && !(prev_state == DIG || prev_state == FALL)) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                end
            end
            
            WALK_RIGHT: begin
                if ((fall_counter > 20 && ground) || (!ground && bump_left) || bump_right) begin
                    next_state = WALK_LEFT;
                end else if (dig && ground && !(prev_state == DIG || prev_state == FALL)) begin
                    next_state = DIG;
                end else if (!ground) begin
                    next_state = FALL;
                end
            end
            
            FALL: begin
                if (fall_counter > 20 && ground) begin
                    next_state = SPLATTER;
                end else if (ground) begin
                    next_state = last_state;
                end
            end
            
            DIG: begin
                if (fall_counter > 20 && ground) begin
                    next_state = SPLATTER;
                end else if (!ground) begin
                    next_state = FALL;
                end else if (!dig) begin
                    next_state = last_state;
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
