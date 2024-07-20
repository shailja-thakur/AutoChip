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
    wire walking;
    wire falling;
    wire digging;
    
    is_falling falling_block(.ground(ground), .falling(falling));
    is_walking walking_block(.bump_left(bump_left), .bump_right(bump_right), .walk_left(walk_left), .walk_right(walk_right));
    is_digging digging_block(.walk_left(walk_left), .walk_right(walk_right), .dig(dig), .digging(digging));
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to walk left state
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case(state)
                2'b00: begin // Fall state
                    walk_left <= walking;
                    walk_right <= ~walking;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                    
                    if (ground) begin
                        if (walking) begin
                            state <= 2'b01; // If ground=1 and walking, go to walk left state
                        end else begin
                            state <= 2'b10; // If ground=1 and not walking, go to walk right state
                        end
                    end
                end
                
                2'b01: begin // Walk left state
                    walk_left <= walking;
                    walk_right <= ~walking;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    
                    if (dig && !falling) begin
                        state <= 2'b11; // If dig=1 and not falling, go to dig state
                    end else if (!walking && !digging && !falling) begin
                        state <= 2'b00; // If not walking or digging or falling, go to fall state
                    end else if (bump_right && !falling) begin
                        state <= 2'b10; // If bump right and not falling, go to walk right state
                    end
                end
                
                2'b10: begin // Walk right state
                    walk_left <= walking;
                    walk_right <= ~walking;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    
                    if (dig && !falling) begin
                        state <= 2'b11; // If dig=1 and not falling, go to dig state
                    end else if (!walking && !digging && !falling) begin
                        state <= 2'b00; // If not walking or digging or falling, go to fall state
                    end else if (bump_left && !falling) begin
                        state <= 2'b01; // If bump left and not falling, go to walk left state
                    end
                end
                
                2'b11: begin // Dig state
                    walk_left <= walking;
                    walk_right <= ~walking;
                    aaah <= 1'b0;
                    digging <= digging;
                    
                    if (!walking && !digging && !falling) begin
                        state <= 2'b00; // If not walking or digging or falling, go to fall state
                    end
                end
                
                default: state <= 2'b01; // Default state is walk left state
            endcase
        end
    end
endmodule
module is_falling(
    input ground,
    output falling
);
    reg prev_ground;
    
    always @(*) begin
        if (prev_ground && !ground) begin
            falling = 1'b1;
        end else begin
            falling = 1'b0;
        end
        prev_ground = ground;
    end
endmodule
module is_walking(
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    assign walk_left = !bump_right;
    assign walk_right = !bump_left;
endmodule
module is_digging(
    input walk_left,
    input walk_right,
    input dig,
    output digging
);
    assign digging = (walk_left || walk_right) && dig;
endmodule
