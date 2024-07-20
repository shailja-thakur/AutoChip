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

    typedef enum logic [2:0] {
        WL = 3'b000,  // Walk left
        WR = 3'b001,  // Walk right
        FL = 3'b010,  // Fall left
        FR = 3'b011,  // Fall right
        DL = 3'b100,  // Dig left
        DR = 3'b101,  // Dig right
        SP = 3'b110   // Splatter
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_count;

    // State transition
    always @(*) begin
        next_state = state;
        case(state)
            WL: begin
                if (!ground)
                    next_state = FL;
                else if (dig)
                    next_state = DL;
                else if (bump_left)
                    next_state = WR;
            end
            WR: begin
                if (!ground)
                    next_state = FR;
                else if (dig)
                    next_state = DR;
                else if (bump_right)
                    next_state = WL;
            end
            FL: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SP;
                    else
                        next_state = WL;
                end
            end
            FR: begin
                if (ground) begin
                    if (fall_count > 20)
                        next_state = SP;
                    else
                        next_state = WR;
                end
            end
            DL: begin
                if (!ground)
                    next_state = FL;
            end
            DR: begin
                if (!ground)
                    next_state = FR;
            end
            SP: begin
                next_state = SP;  // Stay in splatter state
            end
        endcase
    end
    
    // State register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == FL || state == FR)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    // Output logic
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = (state == FL) || (state == FR);
    assign digging = (state == DL) || (state == DR);

endmodule
