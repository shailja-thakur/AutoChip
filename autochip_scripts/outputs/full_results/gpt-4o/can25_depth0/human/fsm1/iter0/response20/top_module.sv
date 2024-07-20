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

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_B;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (in) begin
                    next_state = STATE_A;
                    out = 1'b0;
                end else begin
                    next_state = STATE_B;
                    out = 1'b0;
                end
            end
            STATE_B: begin
                if (in) begin
                    next_state = STATE_B;
                    out = 1'b1;
                end else begin
                    next_state = STATE_A;
                    out = 1'b1;
                end
            end
            default: begin
                next_state = STATE_B; // Default state
                out = 1'b1;           // Default output
            end
        endcase
    end

endmodule
