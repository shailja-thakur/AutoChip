module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    // State encoding
    typedef enum reg [2:0] {
        WL = 3'b000, // Walking Left
        WR = 3'b001, // Walking Right
        FL = 3'b010, // Falling Left
        FR = 3'b011  // Falling Right
    } state_t;

    state_t state, next_state;

    // Asynchronous reset and synchronous state transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL; // Default to walking left on reset
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            WL: begin
                if (~ground)
                    next_state = FL; // Walking left and ground disappears -> Fall Left
                else if (bump_left)
                    next_state = WR; // Walking left and bumped on the left -> Walk Right
                else
                    next_state = WL; // Continue Walking Left
            end
            WR: begin
                if (~ground)
                    next_state = FR; // Walking right and ground disappears -> Fall Right
                else if (bump_right)
                    next_state = WL; // Walking right and bumped on the right -> Walk Left
                else
                    next_state = WR; // Continue Walking Right
            end
            FL: begin
                if (ground)
                    next_state = WL; // Fall Left and ground reappears -> Walk Left
                else
                    next_state = FL; // Continue Falling Left
            end
            FR: begin
                if (ground)
                    next_state = WR; // Fall Right and ground reappears -> Walk Right
                else
                    next_state = FR; // Continue Falling Right
            end
            default: next_state = WL;
        endcase
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            WL: walk_left = 1;
            WR: walk_right = 1;
            FL, FR: aaah = 1;
        endcase
    end

endmodule
