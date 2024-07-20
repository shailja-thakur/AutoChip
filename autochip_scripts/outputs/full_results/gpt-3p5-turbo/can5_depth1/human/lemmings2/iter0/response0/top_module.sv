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
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // Start in the walking left state when reset
        else begin
            case (state)
                2'b00: begin // Walking right state
                    if (bump_left || (bump_left && bump_right)) begin
                        state <= 2'b01; // Switch to walking left state if bumped on the left or on both sides
                    end else if (ground == 0) begin
                        state <= 2'b10; // Transition to falling state if ground disappears
                    end
                end
                2'b01: begin // Walking left state
                    if (bump_right || (bump_left && bump_right)) begin
                        state <= 2'b00; // Switch to walking right state if bumped on the right or on both sides
                    end else if (ground == 0) begin
                        state <= 2'b10; // Transition to falling state if ground disappears
                    end
                end
                2'b10: begin // Falling state
                    if (ground) begin
                        if (state == 2'b00)
                            state <= 2'b01; // Transition to walking left state if previously walking right
                        else
                            state <= 2'b00; // Transition to walking right state if previously walking left
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: begin // Walking right state
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            2'b01: begin // Walking left state
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            2'b10: begin // Falling state
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end
    
endmodule
