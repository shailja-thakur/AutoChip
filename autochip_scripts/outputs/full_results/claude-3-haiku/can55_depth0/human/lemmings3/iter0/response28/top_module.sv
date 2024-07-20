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
localparam STATE_WALK_LEFT = 2'b00;
localparam STATE_WALK_RIGHT = 2'b01;
localparam STATE_FALL = 2'b10;
localparam STATE_DIG = 2'b11;

// Current state
reg [1:0] state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        case (state)
            STATE_WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;

                if (bump_right) begin
                    state <= STATE_WALK_RIGHT;
                end
                else if (!ground) begin
                    state <= STATE_FALL;
                end
                else if (dig) begin
                    state <= STATE_DIG;
                end
            end
            STATE_WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;

                if (bump_left) begin
                    state <= STATE_WALK_LEFT;
                end
                else if (!ground) begin
                    state <= STATE_FALL;
                end
                else if (dig) begin
                    state <= STATE_DIG;
                end
            end
            STATE_FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;

                if (ground) begin
                    state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
            STATE_DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;

                if (!ground) begin
                    state <= STATE_FALL;
                end
                else if (!dig) begin
                    state <= (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
        endcase
    end
end

endmodule
