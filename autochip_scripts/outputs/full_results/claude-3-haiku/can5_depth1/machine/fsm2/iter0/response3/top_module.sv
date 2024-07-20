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

    // Combinational logic for next state
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
            default: state = A;
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= state;
    end

    // Output logic
    always @(*) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
