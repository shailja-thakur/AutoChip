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

    reg [4:0] state_reg;
    reg [4:0] state_next;
    reg [4:0] count;
    reg [4:0] fall_count;

    parameter WALK_LEFT = 3'b001;
    parameter WALK_RIGHT = 3'b010;
    parameter FALL = 3'b011;
    parameter DIG = 3'b100;
    parameter SPLATTER = 3'b101;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state_reg <= WALK_LEFT;
            count <= 0;
            fall_count <= 0;
        end else begin
            state_reg <= state_next;
            count <= count + 1;
            fall_count <= (state_next == FALL) ? fall_count + 1 : 0;
        end
    end

    always @* begin
        state_next = state_reg;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case(state_reg)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = (bump_right == 1) || (bump_left == 1 && ground == 1);
                aaah = (ground == 0) && (fall_count >= 20);
                digging = (dig == 1) && (ground == 1);
                state_next = walk_right ? WALK_RIGHT : WALK_LEFT;
            end
            WALK_RIGHT: begin
                walk_right = 1;
                walk_left = (bump_left == 1) || (bump_right == 1 && ground == 1);
                aaah = (ground == 0) && (fall_count >= 20);
                digging = (dig == 1) && (ground == 1);
                state_next = walk_left ? WALK_LEFT : WALK_RIGHT;
            end
            FALL: begin
                aaah = 1;
                walk_left = 0;
                walk_right = 0;
                digging = 0;
                state_next = (ground == 1) ? state_reg : FALL;
            end
            DIG: begin
                digging = 1;
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                state_next = (ground == 0) ? FALL : DIG;
            end
            SPLATTER: begin
                aaah = 0;
                walk_left = 0;
                walk_right = 0;
                digging = 0;
            end
        endcase
    end
endmodule
