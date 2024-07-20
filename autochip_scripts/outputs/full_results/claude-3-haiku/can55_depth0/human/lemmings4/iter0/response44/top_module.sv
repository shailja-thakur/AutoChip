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
localparam WALKING = 2'b10;

reg [1:0] state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_counter <= 5'b0;
    end
    else begin
        case (state)
            WALKING: begin
                if (ground) begin
                    if (bump_left) begin
                        state <= WALK_RIGHT;
                        walk_left <= 1'b0;
                        walk_right <= 1'b1;
                    end
                    else if (bump_right) begin
                        state <= WALK_LEFT;
                        walk_left <= 1'b1;
                        walk_right <= 1'b0;
                    end
                    else if (dig) begin
                        state <= DIGGING;
                        digging <= 1'b1;
                    end
                end
                else begin
                    state <= FALLING;
                    aaah <= 1'b1;
                    fall_counter <= 5'b1;
                end
            end
            FALLING: begin
                aaah <= 1'b1;
                fall_counter <= fall_counter + 5'b1;
                if (ground) begin
                    state <= WALKING;
                    aaah <= 1'b0;
                    if (fall_counter >= 5'b10101) begin
                        walk_left <= 1'b0;
                        walk_right <= 1'b0;
                        digging <= 1'b0;
                    end
                    else begin
                        walk_left <= state == WALK_LEFT;
                        walk_right <= state == WALK_RIGHT;
                        digging <= 1'b0;
                    end
                end
            end
            DIGGING: begin
                digging <= 1'b1;
                if (!ground) begin
                    state <= FALLING;
                    aaah <= 1'b1;
                    fall_counter <= 5'b1;
                end
            end
        endcase
    end
end

endmodule
