module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define the states
    typedef enum reg [1:0] {A, B} state_t;
    state_t state, next_state;

    // Determine the next state (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Update the state (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
