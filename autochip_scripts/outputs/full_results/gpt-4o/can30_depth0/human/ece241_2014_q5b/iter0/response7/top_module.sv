module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State declarations
    typedef enum logic [1:0] {
        A = 2'b01, // One hot encoding for state A
        B = 2'b10  // One hot encoding for state B
    } state_t;

    state_t state, next_state;

    // Sequential block for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinatorial block to determine next state and output
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b0) begin
                    next_state = A;
                    z = 1'b0;
                end
                else begin
                    next_state = B;
                    z = 1'b1;
                end
            end
            B: begin
                if (x == 1'b0) begin
                    next_state = B;
                    z = 1'b1;
                end
                else begin
                    next_state = B;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule
