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

    // Enum representing the different states of the FSM
    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL,
        DIG
    } state_t;

    // Registers to hold the current state and next state
    reg [1:0] current_state;
    reg [1:0] next_state;

    // Outputs
    reg [1:0] output_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset: reset everything to initial state
            current_state <= WALK_LEFT;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            // Synchronous logic: update the state based on the inputs and current state
            current_state <= next_state;
            walk_left <= (current_state == WALK_LEFT);
            walk_right <= (current_state == WALK_RIGHT);
            aaah <= (current_state == FALL);
            digging <= (current_state == DIG);
        end
    end

    always @(current_state or bump_left or bump_right or ground or dig) begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_right) begin
                    next_state <= WALK_RIGHT;
                end else if (~ground) begin
                    next_state <= FALL;
                end else if (dig) begin
                    next_state <= DIG;
                end else begin
                    next_state <= WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                if (bump_left) begin
                    next_state <= WALK_LEFT;
                end else if (~ground) begin
                    next_state <= FALL;
                end else if (dig) begin
                    next_state <= DIG;
                end else begin
                    next_state <= WALK_RIGHT;
                end
            end

            FALL: begin
                if (ground) begin
                    if (current_state == WALK_LEFT) begin
                        next_state <= WALK_LEFT;
                    end else if (current_state == WALK_RIGHT) begin
                        next_state <= WALK_RIGHT;
                    end
                end else begin
                    next_state <= FALL;
                end
            end

            DIG: begin
                if (~ground) begin
                    next_state <= FALL;
                end else begin
                    next_state <= DIG;
                end
            end
        endcase
    end

endmodule
