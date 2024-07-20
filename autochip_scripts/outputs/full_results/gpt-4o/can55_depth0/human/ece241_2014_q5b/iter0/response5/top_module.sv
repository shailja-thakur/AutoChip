module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding: One-hot encoding
    typedef enum reg [1:0] {
        A = 2'b01, // State A
        B = 2'b10  // State B
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next State and Output Logic
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

endmodule
