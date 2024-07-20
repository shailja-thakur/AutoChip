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
localparam [1:0] WALK_LEFT  = 2'b00,
                 WALK_RIGHT = 2'b01,
                 FALLING    = 2'b10,
                 DIGGING    = 2'b11;

// Current state
reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;

                if (ground == 0) begin
                    state <= FALLING;
                end
                else if (dig == 1) begin
                    state <= DIGGING;
                end
                else if (bump_right == 1) begin
                    state <= WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;

                if (ground == 0) begin
                    state <= FALLING;
                end
                else if (dig == 1) begin
                    state <= DIGGING;
                end
                else if (bump_left == 1) begin
                    state <= WALK_LEFT;
                end
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;

                if (ground == 1) begin
                    if (walk_left) begin
                        state <= WALK_LEFT;
                    end
                    else begin
                        state <= WALK_RIGHT;
                    end
                end
            end
            DIGGING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;

                if (ground == 0) begin
                    state <= FALLING;
                end
                else if (dig == 0) begin
                    if (walk_left) begin
                        state <= WALK_LEFT;
                    end
                    else begin
                        state <= WALK_RIGHT;
                    end
                end
            end
        endcase
    end
end

endmodule
