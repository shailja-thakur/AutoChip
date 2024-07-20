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
    reg falling;
    reg previous_dig;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to walk left state
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            falling <= 0;
            previous_dig <= 0;
        end else begin
            case (state)
                2'b00: begin // Fall state
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1;
                    digging <= 0;
                    
                    if (ground) begin
                        if (falling) begin
                            if (walk_left) begin
                                state <= 2'b10; // If ground=1, go to walk left state
                            end else begin
                                state <= 2'b01; // If ground=1, go to walk right state
                            end
                        end else begin
                            state <= 2'b01; // If ground=1 and not falling, stay in walk right state
                        end
                    end
                end
                
                2'b01: begin // Walk left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    falling <= 0;
                    
                    if (bump_right) begin
                        state <= 2'b10; // If bump_right=1, go to walk left state
                    end else if (!ground && !previous_dig) begin
                        state <= 2'b00; // If ground=0 and not digging, go to fall state
                        falling <= 1;
                    end else if (dig) begin
                        state <= 2'b11; // If dig=1, go to dig state
                    end
                end
                
                2'b10: begin // Walk right state
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    falling <= 0;
                    
                    if (bump_left) begin
                        state <= 2'b01; // If bump_left=1, go to walk right state
                    end else if (!ground && !previous_dig) begin
                        state <= 2'b00; // If ground=0 and not digging, go to fall state
                        falling <= 1;
                    end else if (dig) begin
                        state <= 2'b11; // If dig=1, go to dig state
                    end
                end
                
                2'b11: begin // Dig state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    falling <= 0;
                    previous_dig <= dig;
                    
                    if (!ground && !digging) begin
                        state <= 2'b00; // If ground=0 and not digging, go to fall state
                        falling <= 1;
                    end
                end
            endcase
        end
    end
endmodule
