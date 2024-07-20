module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
    );

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    // State registers
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: if (j)
                    next_state = B;
               else
                    next_state = A;
            B: if (k)
                    next_state = A;
               else
                    next_state = B;
        endcase
    end

    // Clocked logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset state to A
        else
            state <= next_state;
    end

    // Output logic based on current state
    always @(*) begin
        if (state == B)
            out = 1;
        else
            out = 0;
    end

endmodule
