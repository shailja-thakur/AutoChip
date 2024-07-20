module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define the states
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
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
            default: begin
                next_state = A;
            end
        endcase
    end

    // State register update
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
                if (x)
                    z = 1;
                else
                    z = 0;
            end
            B: begin
                if (!x)
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
