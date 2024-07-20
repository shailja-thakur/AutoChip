module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // Sequential logic: State transition on the rising edge of the clock or asynchronously reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic: determine next state
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;  // State B remains B always
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
