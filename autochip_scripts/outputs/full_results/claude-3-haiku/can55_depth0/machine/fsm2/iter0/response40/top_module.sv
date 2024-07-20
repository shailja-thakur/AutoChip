module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State variables
    reg state;
    parameter A = 1'b0, B = 1'b1;

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    state = B;
                else
                    state = A;
            end
            B: begin
                if (k)
                    state = A;
                else
                    state = B;
            end
        endcase
    end

    // State update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= state;
    end

    // Output logic
    always @(state) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
