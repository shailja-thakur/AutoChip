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
    reg previous_ground;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10; // Start in walking left state
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            previous_ground <= ground;
            
            case (state)
                2'b00: begin // Walking right state
                    if (bump_right && !ground && !dig) begin
                        next_state <= 2'b01; // Switch to walking left state
                    end else if (bump_left && !ground && !dig) begin
                        next_state <= 2'b00; // Stay in the walking right state
                    end else if (!ground && !dig) begin
                        next_state <= 2'b10; // Switch to falling state
                    end else if (dig && ground && !(bump_right || bump_left)) begin
                        next_state <= 2'b00; // Stay in the walking right state
                        digging <= 1'b1;
                    end else begin
                        next_state <= 2'b00; // Stay in the walking right state
                        digging <= 1'b0;
                    end
                end
                2'b01: begin // Walking left state
                    if (bump_left && !ground && !dig) begin
                        next_state <= 2'b00; // Switch to walking right state
                    end else if (bump_right && !ground && !dig) begin
                        next_state <= 2'b01; // Stay in the walking left state
                    end else if (!ground && !dig) begin
                        next_state <= 2'b10; // Switch to falling state
                    end else if (dig && ground && !(bump_right || bump_left)) begin
                        next_state <= 2'b01; // Stay in the walking left state
                        digging <= 1'b1;
                    end else begin
                        next_state <= 2'b01; // Stay in the walking left state
                        digging <= 1'b0;
                    end
                end
                2'b10: begin // Falling state
                    if (ground && !dig) begin
                        if (previous_ground) begin
                            next_state <= 2'b00; // Stay in the walking right state
                            aaah <= 1'b0;
                        end else begin
                            next_state <= 2'b01; // Stay in the walking left state
                            aaah <= 1'b0;
                        end
                        digging <= 1'b0;
                    end else if (dig && ground && !(bump_right || bump_left)) begin
                        next_state <= 2'b01; // Stay in the walking left state
                        aaah <= 1'b0;
                        digging <= 1'b1;
                    end else begin
                        next_state <= 2'b10; // Stay in the falling state
                        aaah <= 1'b1;
                        digging <= 1'b0;
                    end
                end
                default: begin // Default state (should never happen)
                    next_state <= 2'b10; // Start in walking left state
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                    aaah <= 1'b0;
                    digging <= 1'b0;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        state <= next_state;
        case (state)
            2'b00: begin // Walking right state
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end
            2'b01: begin // Walking left state
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
            2'b10: begin // Falling state
                walk_left <= 1'b0;
                walk_right <= 1'b0;
            end
            default: begin // Default state (should never happen)
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        endcase
    end
endmodule
