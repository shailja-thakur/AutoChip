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

reg [6:0] state;
reg [4:0] state_count;

// State definitions
parameter IDLE = 1'b0;
parameter WALK_LEFT = 1'b1;
parameter WALK_RIGHT = 1'b10;
parameter FALL = 1'b11;
parameter DIG = 1'b100;
parameter SPLATTER = 1'b101;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        state_count <= 0;
    end else begin
        case(state)
            IDLE: begin
                if (bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_right && !bump_left) begin
                    state <= WALK_LEFT;
                end else if (!ground) begin
                    state <= FALL;
                end
                // No state transition
                else begin
                    state <= IDLE;
                end
            end
            
            WALK_LEFT: begin
                if (bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_right && !bump_left) begin
                    state <= WALK_LEFT;
                end else if (dig) begin
                    state <= DIG;
                end else if (!ground) begin
                    state <= FALL;
                end
                // No state transition
                else begin
                    state <= WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left && !bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_right && !bump_left) begin
                    state <= WALK_LEFT;
                end else if (dig) begin
                    state <= DIG;
                end else if (!ground) begin
                    state <= FALL;
                end
                // No state transition
                else begin
                    state <= WALK_RIGHT;
                end
            end
            
            FALL: begin
                if (ground) begin
                    state <= WALK_LEFT;
                end else if (dig) begin
                    state <= DIG;
                end else if (state_count >= 20) begin
                    state <= SPLATTER;
                end
                // No state transition
                else begin
                    state <= FALL;
                end
            end
            
            DIG: begin
                if (!dig) begin
                    state <= WALK_LEFT;
                end else if (!ground) begin
                    state <= FALL;
                end
                // No state transition
                else begin
                    state <= DIG;
                end
            end
            
            SPLATTER: begin
                state <= SPLATTER;
            end
        endcase
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        case(state)
            IDLE: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            FALL: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
            end
            DIG: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
            end
            SPLATTER: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
        endcase
    end
end

endmodule
