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
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

// Define states
parameter [4:0]
    WALK_LEFT = 5'b00001,
    WALK_RIGHT = 5'b00010,
    FALL = 5'b00011,
    DIG = 5'b00100,
    SPLATTER = 5'b00101;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
    end else begin
        case(state)
            WALK_LEFT: begin
                if (bump_left) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end else if (dig && ground) begin
                    state <= DIG;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    digging <= 1'b1;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_RIGHT;
                    walk_left <= 1'b0;
                    walk_right <= 1'b1;
                end else if (bump_right) begin
                    state <= WALK_LEFT;
                    walk_left <= 1'b1;
                    walk_right <= 1'b0;
                end else if (dig && ground) begin
                    state <= DIG;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    digging <= 1'b1;
                end else if (!ground) begin
                    state <= FALL;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                end
            end
            
            FALL: begin
                if (ground) begin
                    state <= WALK_LEFT;
                    walk_left <= (state == WALK_LEFT) ? 1'b1 : 1'b0;
                    walk_right <= (state == WALK_RIGHT) ? 1'b1 : 1'b0;
                    aaah <= 1'b0;
                end else if (dig && ground) begin
                    state <= DIG;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    digging <= 1'b1;
                end
            end
            
            DIG: begin
                if (!ground) begin
                    state <= FALL;
                    walk_left <= 1'b0;
                    walk_right <= 1'b0;
                    aaah <= 1'b1;
                    digging <= 1'b0;
                end
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

always @(state) begin
    case(state)
        SPLATTER: begin
            walk_left <= 1'b0;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end
    endcase
end

endmodule
