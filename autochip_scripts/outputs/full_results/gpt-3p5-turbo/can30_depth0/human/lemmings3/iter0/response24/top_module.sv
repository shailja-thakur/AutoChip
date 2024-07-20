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
parameter IDLE = 2'b00;
parameter WALKING = 2'b01;
parameter DIGGING = 2'b10;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (bump_left && !bump_right)
                    state <= WALKING;
                else if (!bump_left && bump_right)
                    state <= WALKING;
                else if (ground)
                    state <= WALKING;
                else if (dig)
                    state <= DIGGING;
            end
            WALKING: begin
                if (bump_left && !bump_right)
                    state <= WALKING;
                else if (!bump_left && bump_right)
                    state <= WALKING;
                else if (!ground)
                    state <= IDLE;
                else if (dig)
                    state <= DIGGING;
            end
            DIGGING: begin
                if (!ground)
                    state <= DIGGING;
                else if (ground)
                    state <= WALKING;
            end
        endcase
    end
end

always @(posedge clk) begin
    case (state)
        IDLE: begin
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end
        WALKING: begin
            walk_left <= 1'b0;
            walk_right <= 1'b1;
            aaah <= 1'b0;
            digging <= 1'b0;
        end
        DIGGING: begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b1;
        end
    endcase
end

endmodule
