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

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to walk left state
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state;
            case (state)
                2'b00: begin // Fall state
                    if (ground && !falling) begin
                        if (walk_left)
                            next_state = 2'b10; // If ground=1, go to walk left state
                        else
                            next_state = 2'b01; // If ground=1, go to walk right state
                    end else begin
                        next_state = 2'b00;
                    end
                end
                
                2'b01: begin // Walk left state
                    if (bump_right)
                        next_state = 2'b11; // If bump_right=1, go to walk right state
                    else if (!ground || (dig && ground))
                        next_state = 2'b00; // If ground=0 or dig=1, go to fall state
                    else
                        next_state = 2'b01; // Otherwise, stay in walk left state
                end
                
                2'b10: begin // Walk right state
                    if (bump_left)
                        next_state = 2'b01; // If bump_left=1, go to walk left state
                    else if (!ground || (dig && ground))
                        next_state = 2'b00; // If ground=0 or dig=1, go to fall state
                    else
                        next_state = 2'b10; // Otherwise, stay in walk right state
                end
                
                2'b11: begin // Dig state
                    if (!ground)
                        next_state = 2'b00; // If ground=0, go to fall state
                    else
                        next_state = 2'b11; // Otherwise, stay in dig state
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
            
            2'b01: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            
            2'b10: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
            
            2'b11: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
        endcase
    end
endmodule
