module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter A = 1'b0, B = 1'b1;
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: if (x) state <= B;
                B: state <= B;
                default: state <= A;
            endcase
        end
    end

    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end

endmodule
