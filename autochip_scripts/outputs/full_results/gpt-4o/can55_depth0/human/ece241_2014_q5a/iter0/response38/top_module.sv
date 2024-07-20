module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State declarations
    typedef enum logic [1:0] {
        S_WAIT = 2'b00,
        S_OUTPUT = 2'b01,
        S_FLIP = 2'b10,
        S_DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg flip;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= S_WAIT;
        else
            current_state <= next_state;
    end

    // Next state logic and output generation
    always @(*) begin
        next_state = current_state;
        z = 0;

        case (current_state)
            S_WAIT: begin
                if (!areset)
                    next_state = S_FLIP;
            end
            S_FLIP: begin
                z = ~x;
                next_state = S_OUTPUT;
            end
            S_OUTPUT: begin
                if (x == 1'b1) begin
                    next_state = S_FLIP;
                end else begin
                    z = flip ? ~x : x;
                    flip = 1;
                    next_state = S_DONE;
                end
            end
            S_DONE: begin
                if (areset)
                    next_state = S_WAIT;
                else
                    z = 0;
            end
        endcase
    end
endmodule
