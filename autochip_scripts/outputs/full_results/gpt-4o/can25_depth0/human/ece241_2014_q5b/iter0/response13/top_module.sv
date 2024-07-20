module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t state, next_state;

    // State transition on clock edge or asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset to state A
        else
            state <= next_state;
    end

    // Combinational logic for next state and output logic
    always_comb begin
        // Default values
        next_state = state;
        z = 0;
        case (state)
            A: begin
                z = x;
                if (x)
                    next_state = B;
            end
            B: begin
                z = ~x;
                if (x)
                    next_state = B;
                else
                    next_state = B;
            end
        endcase
    end

endmodule
