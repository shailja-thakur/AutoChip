module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define the parameters for states A and B
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A; // Default state should be A
            end
        endcase
    end

    // Sequential logic for state register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1)
                    z = 1;
                else
                    z = 0;
            end
            B: begin
                if (x == 0)
                    z = 1;
                else
                    z = 0;
            end
            default: begin
                z = 0;
            end
        endcase
    end
endmodule
