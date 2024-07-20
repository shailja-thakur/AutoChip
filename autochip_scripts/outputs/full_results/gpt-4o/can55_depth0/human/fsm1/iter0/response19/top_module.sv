module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum logic [1:0] {A = 2'b00, B = 2'b01} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
                out = 0;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out = 1;
            end
            default: begin
                next_state = B; // default state case if undefined behavior
                out = 1;
            end
        endcase
    end

endmodule
