module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State update and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic
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

    // Output logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    z = 1;
                else
                    z = 0;
            end
            B: begin
                if (x)
                    z = 0;
                else
                    z = 1;
            end
            default: begin
                z = 0;
            end
        endcase
    end

endmodule
