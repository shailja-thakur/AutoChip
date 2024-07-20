module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {A = 2'b00, B = 2'b01} state_t;
    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B; // Default state
        endcase
    end

    // State register (sequential)
    always @(posedge clk) begin
        if (reset) state <= B;
        else state <= next_state;
    end

    // Output logic (combinational)
    assign out = (state == B) ? 1 : 0;

endmodule
