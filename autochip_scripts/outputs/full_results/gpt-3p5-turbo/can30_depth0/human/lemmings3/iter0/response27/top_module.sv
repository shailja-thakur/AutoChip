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
reg [1:0] state;
parameter IDLE = 2'b00;
parameter WALKING = 2'b01;
parameter FALLING = 2'b10;
parameter DIGGING = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case(state)
            IDLE: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (ground == 0) begin
                    state <= FALLING;
                end else begin
                    if (bump_right) begin
                        state <= WALKING;
                        walk_left <= 0;
                        walk_right <= 1;
                    end else if (bump_left) begin
                        state <= WALKING;
                        walk_left <= 1;
                        walk_right <= 0;
                    end else if (dig) begin
                        state <= DIGGING;
                        digging <= 1;
                    end
                end
            end
            WALKING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
                if (ground == 0) begin
                    state <= FALLING;
                end else begin
                    if (bump_right) begin
                        state <= IDLE;
                        walk_left <= 1;
                        walk_right <= 0;
                    end else if (bump_left) begin
                        state <= IDLE;
                        walk_left <= 0;
                        walk_right <= 1;
                    end else if (dig) begin
                        state <= DIGGING;
                        digging <= 1;
                    end
                end
            end
            FALLING: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
                if (ground) begin
                    state <= IDLE;
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
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
            end
        endcase
    end
end

endmodule
