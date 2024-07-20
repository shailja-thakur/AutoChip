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

    // Define states
    reg [5:0] state;
    parameter IDLE = 6'b000001;
    parameter WALK_LEFT = 6'b000010;
    parameter WALK_RIGHT = 6'b000100;
    parameter FALLING = 6'b001000;
    parameter DIGGING = 6'b010000;
    parameter SPLATTER = 6'b100000;

    // Define counters
    reg [5:0] fall_counter;

    // Initialize outputs
    always @(posedge clk or posedge areset) begin
        if (areset == 1) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
            fall_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (ground == 0 && bump_left == 0 && bump_right == 0) begin
                        state <= FALLING;
                    end else if (ground == 1 && dig == 1) begin
                        state <= DIGGING;
                    end else if (bump_left == 1 && bump_right == 0) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left == 0 && bump_right == 1) begin
                        state <= WALK_LEFT;
                    end else if (bump_left == 1 && bump_right == 1) begin
                        state <= WALK_RIGHT;
                    end
                end

                WALK_LEFT: begin
                    if (ground == 0) begin
                        state <= FALLING;
                    end else if (bump_left == 1 && bump_right == 0) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left == 0 && bump_right == 1) begin
                        state <= WALK_LEFT;
                    end else if (bump_left == 1 && bump_right == 1) begin
                        state <= WALK_RIGHT;
                    end
                end

                WALK_RIGHT: begin
                    if (ground == 0) begin
                        state <= FALLING;
                    end else if (bump_left == 1 && bump_right == 0) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left == 0 && bump_right == 1) begin
                        state <= WALK_LEFT;
                    end else if (bump_left == 1 && bump_right == 1) begin
                        state <= WALK_LEFT;
                    end
                end

                FALLING: begin
                    if (fall_counter >= 20 && ground == 1) begin
                        state <= SPLATTER;
                    end else if (ground == 1) begin
                        state <= IDLE;
                    end else begin
                        state <= FALLING;
                    end
                end

                DIGGING: begin
                    if (ground == 0) begin
                        state <= FALLING;
                    end else if (ground == 1 && dig == 0) begin
                        state <= WALK_LEFT;
                    end else if (ground == 1 && dig == 1) begin
                        state <= DIGGING;
                    end
                end

                SPLATTER: begin
                    state <= SPLATTER;
                end
            endcase
        end
    end

    // Update outputs
    always @(posedge clk or posedge areset) begin
        if (areset == 1) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (state)
                IDLE: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end

                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end

                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end

                FALLING: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end

                DIGGING: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end

                SPLATTER: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end

endmodule
