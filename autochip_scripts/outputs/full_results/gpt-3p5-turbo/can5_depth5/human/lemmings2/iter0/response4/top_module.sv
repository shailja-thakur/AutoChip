module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

    reg [1:0] state;
    reg walk_left;
    reg walk_right;
    reg aaah;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            state <= 2'b01;  // initialize state to walking left
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
        end
        else
        begin
            case (state)
                2'b00:  // walking left state
                begin
                    if (bump_right)  // switch to walking right state if bumped on the right
                    begin
                        state <= 2'b01;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                        aaah <= 1'b0;
                    end
                    else if (!ground)  // fall if ground disappears
                    begin
                        state <= 2'b11;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                    end
                end
                
                2'b01:  // walking right state
                begin
                    if (bump_left)  // switch to walking left state if bumped on the left
                    begin
                        state <= 2'b00;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                    end
                    else if (!ground)  // fall if ground disappears
                    begin
                        state <= 2'b11;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b1;
                    end
                end
                
                2'b10:  // falling state
                begin
                    if (ground)  // resume walking in the same direction if ground reappears
                    begin
                        if (walk_left)
                        begin
                            state <= 2'b00;
                            walk_left <= 1'b1;
                            walk_right <= 1'b0;
                            aaah <= 1'b0;
                        end
                        else if (walk_right)
                        begin
                            state <= 2'b01;
                            walk_left <= 1'b0;
                            walk_right <= 1'b1;
                            aaah <= 1'b0;
                        end
                    end
                end
            endcase
        end
    end
endmodule
