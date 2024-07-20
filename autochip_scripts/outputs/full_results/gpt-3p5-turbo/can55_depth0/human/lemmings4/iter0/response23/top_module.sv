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

    reg [4:0] state;
    
    // State encoding
    parameter WALK_LEFT = 4'b00001;
    parameter WALK_RIGHT = 4'b00010;
    parameter FALL = 4'b00100;
    parameter DIG = 4'b01000;
    parameter SPLATTER = 4'b10000;

    // Outputs
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                // WALK_LEFT state transitions
                WALK_LEFT:
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                // WALK_RIGHT state transitions
                WALK_RIGHT:
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                // FALL state transitions
                FALL:
                    if (ground) begin
                        state <= WALK_LEFT;
                    end else if (!ground && state_count >= 20) begin
                        state <= SPLATTER;
                    end
                // DIG state transitions
                DIG:
                    if (!ground) begin
                        state <= FALL;
                    else if (!dig) begin
                        state <= WALK_LEFT;
                    end
                // SPLATTER state transitions
                SPLATTER:
                    state <= SPLATTER;
            endcase
        end
    end

endmodule
