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
parameter FALLING = 2'b01;
parameter DIGGING = 2'b10;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (bump_left) begin
                    state <= IDLE;
                    walk_right <= 1;
                    walk_left <= 0;
                end else if (bump_right) begin
                    state <= IDLE;
                    walk_right <= 0;
                    walk_left <= 1;
                end else if (dig && ground) begin
                    state <= DIGGING;
                    walk_right <= 1;
                    walk_left <= 0;
                end else if (~ground) begin
                    state <= FALLING;
                    walk_right <= walk_right;
                    walk_left <= walk_left;
                    aaah <= 1;
                end else begin
                    state <= IDLE;
                    walk_right <= walk_right;
                    walk_left <= walk_left;
                end
            end
            FALLING: begin
                if (ground) begin
                    state <= IDLE;
                    aaah <= 0;
                    walk_right <= walk_right;
                    walk_left <= walk_left;
                end else begin
                    state <= FALLING;
                    aaah <= 1;
                    walk_right <= walk_right;
                    walk_left <= walk_left;
                end
            end
            DIGGING: begin
                if (~ground) begin
                    state <= FALLING;
                    aaah <= 1;
                    walk_right <= walk_right;
                    walk_left <= walk_left;
                end else begin
                    state <= DIGGING;
                    aaah <= 0;
                    walk_right <= 1;
                    walk_left <= 0;
                end
            end
        endcase
    end
end

endmodule
