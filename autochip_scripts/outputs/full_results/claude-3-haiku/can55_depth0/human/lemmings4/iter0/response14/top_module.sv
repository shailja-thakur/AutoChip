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

// Define the states of the Lemming FSM
localparam LEFT = 0, RIGHT = 1, FALLING = 2, DIGGING = 3, SPLATTERED = 4;

// Internal state variables
reg [2:0] state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        case (state)
            LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (bump_right) begin
                    state <= RIGHT;
                end
                else if (!ground) begin
                    state <= FALLING;
                    fall_count <= 1;
                end
                else if (dig) begin
                    state <= DIGGING;
                end
            end
            RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
                if (bump_left) begin
                    state <= LEFT;
                end
                else if (!ground) begin
                    state <= FALLING;
                    fall_count <= 1;
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
                    if (fall_count >= 20) begin
                        state <= SPLATTERED;
                    end
                    else begin
                        if (walk_left) begin
                            state <= LEFT;
                        end
                        else begin
                            state <= RIGHT;
                        end
                    end
                    fall_count <= 0;
                end
                else begin
                    fall_count <= fall_count + 1;
                end
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALLING;
                    fall_count <= 1;
                end
            end
            SPLATTERED: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            default: begin
                state <= LEFT;
            end
        endcase
    end
end

endmodule
