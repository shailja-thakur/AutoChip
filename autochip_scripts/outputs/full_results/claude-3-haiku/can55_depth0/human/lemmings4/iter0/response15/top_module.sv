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
parameter WALK_LEFT = 3'd0;
parameter WALK_RIGHT = 3'd1;
parameter FALLING = 3'd2;
parameter DIGGING = 3'd3;
parameter SPLATTERED = 3'd4;

reg [2:0] state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= FALLING;
                    fall_counter <= 1;
                end
                else if (dig) begin
                    state <= DIGGING;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end
                else if (!ground) begin
                    state <= FALLING;
                    fall_counter <= 1;
                end
                else if (dig) begin
                    state <= DIGGING;
                end
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    if (fall_counter >= 20) begin
                        state <= SPLATTERED;
                    end
                    else begin
                        if (walk_left) begin
                            state <= WALK_LEFT;
                        end
                        else begin
                            state <= WALK_RIGHT;
                        end
                        fall_counter <= 0;
                    end
                end
                else begin
                    fall_counter <= fall_counter + 1;
                end
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALLING;
                    fall_counter <= 1;
                end
                else if (!dig) begin
                    state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                end
            end
            SPLATTERED: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
end

endmodule
