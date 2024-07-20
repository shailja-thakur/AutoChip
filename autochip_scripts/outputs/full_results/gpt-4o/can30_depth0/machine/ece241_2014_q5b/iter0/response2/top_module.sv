module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1; 

    // Register to store the state
    reg state, next_state;

    // State transition logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (x) next_state = B;
                else next_state = A;
            end
            B: begin
                next_state = B; // Remain in state B
            end
            default: next_state = A; // Default should not happen
        endcase
    end

    // State register update (sequential logic)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x;
            B: z = 0;
            default: z = 0; // Default should not happen
        endcase
    end

endmodule
