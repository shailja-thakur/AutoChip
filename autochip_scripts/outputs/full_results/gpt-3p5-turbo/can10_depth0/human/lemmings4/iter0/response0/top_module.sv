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

    parameter [4:0] WALK_LEFT = 5'b00001;
    parameter [4:0] WALK_RIGHT = 5'b00010;
    parameter [4:0] FALL = 5'b00011;
    parameter [4:0] DIG = 5'b00100;
    parameter [4:0] SPLATTER = 5'b01000;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right == 1)
                        state <= WALK_RIGHT;
                    else if (bump_left == 1)
                        state <= WALK_LEFT;
                    else if (ground == 0)
                        state <= FALL;
                    else if (dig == 1 && ground == 1)
                        state <= DIG;
                end
                WALK_RIGHT: begin
                    if (bump_left == 1)
                        state <= WALK_LEFT;
                    else if (bump_right == 1)
                        state <= WALK_RIGHT;
                    else if (ground == 0)
                        state <= FALL;
                    else if (dig == 1 && ground == 1)
                        state <= DIG;
                end
                FALL: begin
                    if (ground == 1)
                        state <= state[3:0];
                    else if (dig == 1 && ground == 1)
                        state <= DIG;
                    else if (state[4] == 1 && ground == 1)
                        state <= SPLATTER;
                    else
                        state <= FALL + 1;
                end
                DIG: begin
                    if (ground == 0)
                        state <= state[3:0];
                    else if (bump_right == 1)
                        state <= WALK_RIGHT;
                    else if (bump_left == 1)
                        state <= WALK_LEFT;
                    else if (dig == 1 && ground == 1)
                        state <= DIG;
                    else if (state[4] == 1 && ground == 1)
                        state <= SPLATTER;
                end
                SPLATTER: begin
                    state <= SPLATTER;
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
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
