module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    typedef enum logic [1:0] {
        B,
        A
    } state_t;

    reg state_t current_state, next_state;
    reg   out;

    always_ff @(posedge clk or negedge areset) begin
        if (areset) begin
            current_state <= B;
            out <= 1'b0;
        end
        else begin
            current_state <= next_state;
            out <= (current_state == A);
        end
    end

    always_comb begin
        case (current_state)
            B: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = B;
        endcase
    end

endmodule
