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
            state <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        walk_left = (state == 2'b01);
        walk_right = (state == 2'b10);
        aaah = (state == 2'b00);
        digging = (state == 2'b11);
        
        next_state = state;
        
        case (state)
            2'b00: begin // Fall state
                if (ground) begin
                    if (bump_left) begin
                        next_state = 2'b01; // If ground=1 and bump_left=1, go to walk left state
                    end else if (bump_right) begin
                        next_state = 2'b10; // If ground=1 and bump_right=1, go to walk right state
                    end
                end
            end
            
            2'b01: begin // Walk left state
                if (ground || dig) begin
                    if (bump_left) begin
                        next_state = 2'b01; // If bump_left=1, stay in walk left state
                    end else if (bump_right || (!ground && !dig)) begin
                        next_state = 2'b10; // If bump_right=1 or ground=0 and dig=0, go to walk right state
                    end else if (!ground && dig) begin
                        next_state = 2'b00; // If ground=0 and dig=1, go to fall state
                    end
                end
            end
            
            2'b10: begin // Walk right state
                if (ground || dig) begin
                    if (bump_right) begin
                        next_state = 2'b10; // If bump_right=1, stay in walk right state
                    end else if (bump_left || (!ground && !dig)) begin
                        next_state = 2'b01; // If bump_left=1 or ground=0 and dig=0, go to walk left state
                    end else if (!ground && dig) begin
                        next_state = 2'b00; // If ground=0 and dig=1, go to fall state
                    end
                end
            end
            
            2'b11: begin // Dig state
                if (!ground) begin
                    next_state = 2'b00; // If ground=0, go to fall state
                end
            end
        endcase
    end
endmodule
