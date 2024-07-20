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

// Define the states
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

// Current state register
reg [1:0] current_state;

// Fall counter
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        case (current_state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    current_state <= WALK_RIGHT;
                end
                else if (!ground) begin
                    current_state <= FALL;
                    fall_count <= 1;
                end
                else if (dig) begin
                    current_state <= DIG;
                    digging <= 1;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    current_state <= WALK_LEFT;
                end
                else if (!ground) begin
                    current_state <= FALL;
                    fall_count <= 1;
                end
                else if (dig) begin
                    current_state <= DIG;
                    digging <= 1;
                end
            end
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    if (fall_count > 20) begin
                        // Splatter
                        walk_left <= 0;
                        walk_right <= 0;
                        aaah <= 0;
                        digging <= 0;
                    end
                    else begin
                        // Resume walking
                        if (current_state == WALK_LEFT) begin
                            current_state <= WALK_LEFT;
                            walk_left <= 1;
                            walk_right <= 0;
                        end
                        else begin
                            current_state <= WALK_RIGHT;
                            walk_left <= 0;
                            walk_right <= 1;
                        end
                        aaah <= 0;
                    end
                    fall_count <= 0;
                end
                else begin
                    fall_count <= fall_count + 1;
                end
            end
            DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    current_state <= FALL;
                    fall_count <= 1;
                    digging <= 0;
                end
                else if (!dig) begin
                    current_state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                    digging <= 0;
                end
            end
        endcase
    end
end

endmodule
