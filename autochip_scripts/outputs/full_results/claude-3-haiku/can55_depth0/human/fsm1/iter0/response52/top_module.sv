module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg state;
    parameter A = 1'b0, B = 1'b1;

    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= B;
        else begin
            case (state)
                A: begin
                    if (in)
                        state <= A;
                    else
                        state <= B;
                end
                B: begin
                    if (in)
                        state <= B;
                    else
                        state <= A;
                end
            endcase
        end
    end

    always @(*) begin
        out = (state == A) ? 0 : 1;
    end

endmodule
