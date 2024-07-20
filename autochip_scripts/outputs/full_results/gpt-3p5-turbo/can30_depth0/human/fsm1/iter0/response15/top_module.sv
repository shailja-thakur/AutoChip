module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    parameter B = 2'b00;
    parameter A = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    always @* begin
        case (state)
            B:
                if (in)
                    next_state = B;
                else
                    next_state = A;
            A:
                if (in)
                    next_state = A;
                else
                    next_state = B;
        endcase
    end

    always @(posedge clk) begin
        if (state == B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
