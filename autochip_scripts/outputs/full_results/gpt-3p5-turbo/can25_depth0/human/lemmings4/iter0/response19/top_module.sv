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
    wire [4:0] next_state;
    reg walk_left;
    reg walk_right;
    reg aaah;
    reg digging;
    
    parameter LEFT = 3'b000;
    parameter RIGHT = 3'b001;
    parameter FALLING = 3'b010;
    parameter DIGGING = 3'b011;
    parameter SPLATTERED = 3'b100;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            state <= next_state;
            walk_left <= (state == LEFT);
            walk_right <= (state == RIGHT);
            aaah <= (state == FALLING);
            digging <= (state == DIGGING);
        end
    end
    
    always @(state, bump_left, bump_right, ground, dig) begin
        next_state = state;
        case (state)
            LEFT: begin
                if (bump_right) begin
                    next_state = RIGHT;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (!ground) begin
                    next_state = FALLING;
                end
            end
            RIGHT: begin
                if (bump_left) begin
                    next_state = LEFT;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (!ground) begin
                    next_state = FALLING;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = state;
                end
            end
            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING;
                end
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
        endcase
    end
    
    always @(state) begin
        case (state)
            SPLATTERED: begin
                walk_left <= 0;
                walk_right <= 0;
                aaah <= 0;
                digging <= 0;
            end
        endcase
    end

endmodule
