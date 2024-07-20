module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define states
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (x) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end

endmodule
