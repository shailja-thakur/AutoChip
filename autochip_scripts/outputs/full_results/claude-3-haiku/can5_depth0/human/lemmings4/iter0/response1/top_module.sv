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

localparam WALK_LEFT = 1'b1;
localparam WALK_RIGHT = 1'b0;
localparam FALLING = 2'b00;
localparam DIGGING = 2'b01;
localparam SPLATTERED = 2'b10;

reg [1:0] state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_count <= 5'b0;
    end
    else begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_count <= 5'b0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end
                else if (!ground) begin
                    state <= FALLING;
                    aaah <= 1'b1;
                end
                else if (dig & ground) begin
                    state <= DIGGING;
                    digging <= 1'b1;
                end
            end
            WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_count <= 5'b0;
                if (bump_left) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end
                else if (!ground) begin
                    state <= FALLING;
                    aaah <= 1'b1;
                end
                else if (dig & ground) begin
                    state <= DIGGING;
                    digging <= 1'b1;
                end
            end
            FALLING: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1'b1;
                digging <= 1'b0;
                fall_count <= fall_count + 1'b1;
                if (ground) begin
                    if (fall_count >= 20) begin
                        state <= SPLATTERED;
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        aaah <= 1'b0;
                        digging <= 1'b0;
                    end
                    else begin
                        state <= (walk_left) ? WALK_LEFT : WALK_RIGHT;
                        aaah <= 1'b0;
                    end
                    fall_count <= 5'b0;
                end
            end
            DIGGING: begin
                walk_left <= walk_left;
                walk_right <= walk_right;
                aaah <= 1'b0;
                digging <= 1'b1;
                fall_count <= 5'b0;
                if (!ground) begin
                    state <= FALLING;
                    aaah <= 1'b1;
                end
            end
            SPLATTERED: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_count <= 5'b0;
            end
            default: begin
                state <= WALK_LEFT;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
                fall_count <= 5'b0;
            end
        endcase
    end
end

endmodule
