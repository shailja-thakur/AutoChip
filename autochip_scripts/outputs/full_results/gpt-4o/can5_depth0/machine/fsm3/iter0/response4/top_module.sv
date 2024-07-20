module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: begin
                if (in) next_state = B;
                else next_state = A;
            end
            B: begin
                if (in) next_state = B;
                else next_state = C;
            end
            C: begin
                if (in) next_state = D;
                else next_state = A;
            end
            D: begin
                if (in) next_state = B;
                else next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always_comb begin
        out = (state == D) ? 1'b1 : 1'b0;
    end

endmodule
