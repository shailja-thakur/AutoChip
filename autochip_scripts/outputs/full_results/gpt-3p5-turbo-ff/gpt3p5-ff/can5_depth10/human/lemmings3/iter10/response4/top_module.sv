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

    reg [2:0] state;
    reg falling;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 3'b001; // Reset to walk left state
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case (state)
                3'b000: // Fall state
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                    
                    if (ground) begin
                        if (falling) begin
                            if (walk_left) begin
                                state <= 3'b001; // If ground=1, go to walk left state
                            end else begin
                                state <= 3'b010; // If ground=1, go to walk right state
                            end
                        end else begin
                            if (walk_left) begin
                                state <= 3'b001; // If ground=1 and not falling, stay in walk left state
                            end else begin
                                state <= 3'b010; // If ground=1 and not falling, stay in walk right state
                            end
                        end
                    end
                
                3'b001: // Walk left state
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                    
                    if (bump_right) begin
                        state <= 3'b010; // If bump_right=1, go to walk right state
                    end else if (!ground && !digging) begin
                        state <= 3'b000; // If ground=0 and not digging, go to fall state
                        falling <= 1'b1;
                    end else if (dig) begin
                        state <= 3'b011; // If dig=1, go to dig state
                    end
                
                3'b010: // Walk right state
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                    aaah <= 1'b0;
                    digging <= 1'b0;

                    if (bump_left) begin
                        state <= 3'b001; // If bump_left=1, go to walk left state
                    end else if (!ground && !digging) begin
                        state <= 3'b000; // If ground=0 and not digging, go to fall state
                        falling <= 1'b1;
                    end else if (dig) begin
                        state <= 3'b011; // If dig=1, go to dig state
                    end

                3'b011: // Dig state
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b1;

                    if (!ground && !digging) begin
                        state <= 3'b000; // If ground=0 and not digging, go to fall state
                        falling <= 1'b1;
                    end
            endcase
        end
    end
endmodule
