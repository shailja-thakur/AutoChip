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
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 3'b001; // Reset to walk left state
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (state)
                3'b000: begin // Fall state
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1;
                    digging <= 0;
                    
                    if (ground) begin
                        if (walk_left) begin
                            state <= 3'b010; // If ground=1, go to walk left state
                        end else begin
                            state <= 3'b100; // If ground=1, go to walk right state
                        end
                    end
                end
                
                3'b001: begin // Walk left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    
                    if (bump_right) begin
                        state <= 3'b100; // If bump_right=1, go to walk right state
                    end else if (!ground) begin
                        state <= 3'b000; // If ground=0, go to fall state
                    end else if (dig) begin
                        state <= 3'b100; // If dig=1, go to walk right state
                    end
                end
                
                3'b010: begin // Walk left (fallen) state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    
                    if (!ground) begin
                        state <= 3'b000; // If ground=0, go to fall state
                    end
                end
                
                3'b100: begin // Walk right state
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    
                    if (bump_left) begin
                        state <= 3'b001; // If bump_left=1, go to walk left state
                    end else if (!ground) begin
                        state <= 3'b000; // If ground=0, go to fall state
                    end else if (dig) begin
                        state <= 3'b000; // If dig=1, go to fall state
                    end
                end
                
                3'b101: begin // Walk right (fallen) state
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 1;
                    digging <= 0;
                    
                    if (!ground) begin
                        state <= 3'b000; // If ground=0, go to fall state
                    end
                end
                
                3'b110: begin // Dig state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    
                    if (!ground) begin
                        state <= 3'b000; // If ground=0, go to fall state
                    end
                end
            endcase
        end
    end
endmodule
