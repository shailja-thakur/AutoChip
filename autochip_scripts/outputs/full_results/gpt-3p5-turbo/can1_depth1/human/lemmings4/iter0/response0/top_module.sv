module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

reg [6:0] state;

// State definitions
parameter IDLE = 1'b0;
parameter WALK_LEFT = 1'b1;
parameter WALK_RIGHT = 1'b10;
parameter FALL = 1'b11;
parameter DIG = 1'b100;
parameter SPLATTER = 1'b101;

// Output assignments
assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign aaah = (state == FALL || state == SPLATTER);
assign digging = (state == DIG);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
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

endmodule
