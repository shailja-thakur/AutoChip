module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    reg state, next_state;

    always @(*) begin
        case(state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (state == B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
