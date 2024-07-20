module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);
    reg [4:0] state;
    
    always @(posedge clk or posedge areset)
    if (areset) begin
        state <= 0;
    end else begin
        case (state)
            0: begin // Walking left state
                if (bump_right && !bump_left && ground) begin
                    state <= 1; // Switch to walking right state
                end else if (!bump_right && ground) begin
                    walk_left <= 1; // Continue walking left
                end else if (bump_right && bump_left && ground) begin
                    state <= 2; // Switch to walking right state (bumped on both sides)
                end else if (!ground) begin
                    state <= 3; // Falling state
                end
            end
            1: begin // Walking right state
                if (bump_left && !bump_right && ground) begin
                    state <= 0; // Switch to walking left state
                end else if (!bump_left && ground) begin
                    walk_right <= 1; // Continue walking right
                end else if (bump_left && bump_right && ground) begin
                    state <= 2; // Switch to walking left state (bumped on both sides)
                end else if (!ground) begin
                    state <= 3; // Falling state
                end
            end
            2: begin // Bumped on both sides state
                if (ground) begin
                    state <= 0; // Switch to walking left state
                end else if (!ground) begin
                    walk_right <= 1; // Continue walking right
                end
            end
            3: begin // Falling state
                if (ground) begin
                    state <= 0; // Switch to walking left state
                end else if (state <= 20) begin
                    aaah <= 1; // Splatter if falling for too long
                end else if (!ground && state > 20) begin
                    state <= 0; // Reset state
                end
            end
        endcase
    end
    
    always @(state)
    case (state)
        0: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        1: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
        end
        2: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
        end
        3: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
        end
    endcase
endmodule
