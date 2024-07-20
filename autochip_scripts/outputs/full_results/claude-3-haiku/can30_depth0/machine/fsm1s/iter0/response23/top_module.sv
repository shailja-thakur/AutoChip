module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end else begin
            case (state)
                A: state <= (in) ? A : B;
                B: state <= (in) ? B : A;
            endcase
        end
    end

    always @* begin
        out = (state == B);
    end

endmodule
