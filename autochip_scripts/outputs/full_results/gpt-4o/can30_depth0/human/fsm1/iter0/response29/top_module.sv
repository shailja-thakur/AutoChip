module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_A: begin
                if (in)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
                out = 1'b0; // out is 0 in state A
            end

            STATE_B: begin
                if (in)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
                out = 1'b1; // out is 1 in state B
            end

            default: begin
                next_state = STATE_B; // Default state is B
                out = 1'b1; // Default output is 1
            end
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B; // Asynchronous reset to state B
        else
            state <= next_state; // State transition on clock edge
    end

endmodule
