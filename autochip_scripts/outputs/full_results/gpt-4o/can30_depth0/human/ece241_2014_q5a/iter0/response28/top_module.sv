module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        IDLE = 2'd0,
        INVERT = 2'd1,
        COPY = 2'd2
    } state_t;

    state_t state, next_state;
    logic invert_next;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        next_state = state;
        z = 0;
        case (state)
            IDLE: begin
                if (!areset) begin
                    next_state = INVERT;
                    z = x;
                end
            end
            INVERT: begin
                if (x)
                    next_state = COPY;
                z = ~x;
            end
            COPY: begin
                z = x;
            end
        endcase
    end
endmodule
