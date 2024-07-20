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
    typedef enum reg [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALLING_LEFT = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic: state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= LEFT;     // Asynchronous reset to walking left state
        else
            current_state <= next_state;
    end

    // Combinational logic: next state logic and outputs
    always @(*) begin
        // Default output values
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        
        case (current_state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALLING_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
                walk_left = 1'b1;
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALLING_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
                walk_right = 1'b1;
            end
            FALLING_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALLING_LEFT;
                end
                aaah = 1'b1;
            end
            FALLING_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALLING_RIGHT;
                end
                aaah = 1'b1;
            end
        endcase
    end

endmodule
