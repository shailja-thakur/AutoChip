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
    reg [4:0] next_state;
    
    localparam WALK_LEFT = 3'b001;
    localparam WALK_RIGHT = 3'b010;
    localparam FALLING = 3'b011;
    localparam DIGGING = 3'b100;
    localparam SPLATTER = 3'b101;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end
                walk_left = 1;
            end
            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (ground == 0) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end
                walk_right = 1;
            end
            FALLING: begin
                if (ground == 1) begin
                    next_state = state;
                end else if (state == FALLING && aaah < 20) begin
                    aaah = 1;
                    next_state = FALLING;
                end else begin
                    next_state = SPLATTER;
                end
            end
            DIGGING: begin
                if (ground == 0) begin
                    next_state = FALLING;
                end else begin
                    next_state = DIGGING;
                end
                digging = 1;
            end
            SPLATTER: begin
                // No transitions from SPLATTER state, stays in this state forever
            end
        endcase
    end
endmodule
