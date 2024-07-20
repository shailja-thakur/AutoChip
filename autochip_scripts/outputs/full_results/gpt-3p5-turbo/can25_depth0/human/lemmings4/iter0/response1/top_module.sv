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
    reg [4:0] state;

    localparam IDLE = 0;
    localparam WALK_LEFT = 1;
    localparam WALK_RIGHT = 2;
    localparam FALL = 3;
    localparam DIG = 4;
    localparam SPLATTER = 5;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case(state)
                IDLE: begin
                    if (bump_left && bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (bump_right) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                WALK_LEFT: begin
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                FALL: begin
                    if (ground) begin
                        state <= IDLE;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                DIG: begin
                    if (!ground) begin
                        state <= FALL;
                    end
                end
                SPLATTER: begin
                    state <= SPLATTER;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            IDLE: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            WALK_LEFT: begin
                walk_left <= 1;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
            WALK_RIGHT: begin
                walk_left <= 0;
                walk_right <= 1;
                aaah <= 0;
                digging <= 0;
            end
            FALL: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 1;
                digging <= 0;
            end
            DIG: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 1;
            end
            SPLATTER: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end
endmodule
