module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always_comb begin
        case (state)
            A: if (in) next_state = B; else next_state = A;
            B: if (in) next_state = B; else next_state = C;
            C: if (in) next_state = D; else next_state = A;
            D: if (in) next_state = B; else next_state = C;
            default: next_state = A; // default case to handle unexpected values
        endcase
    end

    // State register (sequential)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always_comb begin
        case (state)
            A: out = 0;
            B: out = 0;
            C: out = 0;
            D: out = 1;
        endcase
    end

endmodule
