module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    reg state, next_state;

    // Define states
    localparam A = 1'b0, B = 1'b1;

    // State transition
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
            default: begin
                next_state = A;
            end
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
