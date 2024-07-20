module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    // State encoding
    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01
    } state_t;
    
    state_t state, next_state;

    // State transition logic (Moore FSM)
    always @(*) begin
        case (state)
            LEFT: begin
                if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            LEFT: begin
                walk_left = 1;
                walk_right = 0;
            end
            RIGHT: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end
endmodule
