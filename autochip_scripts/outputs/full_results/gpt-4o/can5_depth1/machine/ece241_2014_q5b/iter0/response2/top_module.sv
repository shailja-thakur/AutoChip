module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State parameters
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition and output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

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
        endcase
    end

    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end

endmodule
