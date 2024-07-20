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

// State definitions
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

// Internal signals
reg [1:0] state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset to initial state
        state <= WALK_LEFT;
        fall_count <= 0;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case(state)
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (!ground) begin
                    state <= FALL;
                end else if (dig) begin
                    state <= DIG;
                end
            end
            
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (!ground) begin
                    state <= FALL;
                end else if (dig) begin
                    state <= DIG;
                end
            end
            
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                if (ground) begin
                    state <= WALK_LEFT;
                    fall_count <= 0;
                end else if (dig) begin
                    state <= DIG;
                end else if (fall_count < 5'd20) begin
                    fall_count <= fall_count + 1;
                end
            end
            
            DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
                if (!ground) begin
                    state <= FALL;
                end else if (fall_count < 5'd20) begin
                    fall_count <= fall_count + 1;
                end
            end
        endcase
    end
end

endmodule
