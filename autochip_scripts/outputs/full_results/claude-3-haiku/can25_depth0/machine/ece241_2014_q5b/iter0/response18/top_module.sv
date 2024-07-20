module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    always @(posedge clk, posedge areset) begin
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
            default: begin
                next_state = A;
            end
        endcase
    end

    assign z = (state == A && x) || (state == B && ~x);

endmodule
