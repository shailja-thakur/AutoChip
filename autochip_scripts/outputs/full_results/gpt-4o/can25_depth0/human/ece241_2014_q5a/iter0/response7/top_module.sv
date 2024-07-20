module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        S_IDLE  = 2'b00,
        S_1ST_1 = 2'b01,
        S_COMP  = 2'b10
    } state_t;

    state_t state, next_state;
    reg complement;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values
        next_state = state;
        z = 1'b0;

        case (state)
            S_IDLE: begin
                if (x == 1'b0) begin
                    next_state = S_IDLE;
                    z = 1'b0;
                end else begin
                    next_state = S_1ST_1;
                    z = 1'b1;
                end
            end
            S_1ST_1: begin
                if (x == 1'b0) begin
                    next_state = S_COMP;
                    z = 1'b1;
                end else begin
                    next_state = S_1ST_1;
                    z = 1'b0;
                end
            end
            S_COMP: begin
                z = ~x;
                if (areset)
                    next_state = S_IDLE;
                else
                    next_state = S_COMP;
            end
        endcase
    end
endmodule
