module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // State parameters
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;

    // Output logic
    assign z = (state == A && x == 1'b1) || (state == B && x == 1'b0);

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
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
            default: next_state = A; // Shouldn't happen; good practice to default
        endcase
    end
endmodule
