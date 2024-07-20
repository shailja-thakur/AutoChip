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
    reg [1:0] next_state; // Add next_state variable
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01; // Reset to walk left state
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state; // Update state at the end of the clock cycle
            
            case (state)
                2'b00: begin // Fall state
                    walk_left <= walk_left;
                    walk_right <= walk_right;
                    aaah <= 1;
                    digging <= 0;
                    
                    if (ground) begin
                        if (walk_left) begin
                            next_state <= 2'b10; // If ground=1, go to walk left state
                        end else begin
                            next_state <= 2'b11; // If ground=1, go to walk right state
                        end
                    end else begin
                        next_state <= 2'b00;
                    end
                end
                
                2'b01: begin // Walk left state
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    
                    if (bump_right) begin
                        next_state <= 2'b11; // If bump_right=1, go to walk right state
                    end else if (!ground) begin
                        next_state <= 2'b00; // If ground=0, go to fall state
                    end else if (dig) begin
                        next_state <= 2'b01; // If dig=1, stay in walk left state
                    end else begin
                        next_state <= 2'b01; // Default state transition
                    end
                end
                
                2'b10: begin // Walk right state
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    
                    if (bump_left) begin
                        next_state <= 2'b01; // If bump_left=1, go to walk left state
                    end else if (!ground) begin
                        next_state <= 2'b00; // If ground=0, go to fall state
                    end else if (dig) begin
                        next_state <= 2'b10; // If dig=1, stay in walk right state
                    end else begin
                        next_state <= 2'b10; // Default state transition
                    end
                end
                
                2'b11: begin // Dig state
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                    
                    if (!ground) begin
                        next_state <= 2'b00; // If ground=0, go to fall state
                    end else begin
                        next_state <= 2'b11; // Default state transition
                    end
                end
            endcase
        end
    end
endmodule
