module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state, next_state;

    always @(*) begin
        case (state)
            A: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (in == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
