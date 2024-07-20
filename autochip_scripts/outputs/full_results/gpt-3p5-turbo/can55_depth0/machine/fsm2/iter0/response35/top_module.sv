module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define the state enumeration
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    // Define the state and next_state variables
    state_t state, next_state;

    // Declare the next_state logic
    always_comb begin
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
        endcase
    end

    // Declare the state update logic
    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Assign the out port based on the current state
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
