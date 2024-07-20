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

    reg [1:0] state;
    reg [4:0] fall_counter;

    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                        fall_counter <= 0;
                    end else if (dig) begin
                        state <= DIG;
                    end
                WALK_RIGHT:
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                        fall_counter <= fall_counter + 1;
                    end else if (dig) begin
                        state <= DIG;
                    end
                FALL:
                    if (ground) begin
                        state <= WALK_LEFT;
                    end else if (fall_counter >= 20) begin
                        state <= WALK_LEFT;
                        fall_counter <= 0;
                    end else if (dig) begin
                        state <= DIG;
                    end
                DIG:
                    if (!ground || dig) begin
                        state <= DIG;
                    end else begin
                        state <= WALK_RIGHT;
                    end
            endcase
        end
    end

    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

endmodule
