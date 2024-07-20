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

reg [20:0] fall_counter;
reg [1:0] state;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter DIG = 2'b10;
parameter FALL = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (ground == 0) begin
                    state <= FALL;
                    fall_counter <= 0;
                end else if (dig) begin
                    if (ground) begin
                        state <= DIG;
                    end 
                end
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (ground == 0) begin
                    state <= FALL;
                    fall_counter <= 0;
                end else if (dig) begin
                    if (ground) begin
                        state <= DIG;
                    end 
                end
            end
            DIG: begin
                if (bump_left || bump_right) begin
                    state <= DIG;
                end else if (!ground) begin
                    state <= FALL;
                    fall_counter <= 0;
                end else begin
                    state <= WALK_LEFT;
                end
            end
            FALL: begin
                if (ground) begin
                    state <= WALK_LEFT;
                end else if (fall_counter >= 20) begin
                    state <= WALK_LEFT;
                end else begin
                    state <= FALL;
                    fall_counter <= fall_counter + 1;
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
    endcase
end

endmodule
