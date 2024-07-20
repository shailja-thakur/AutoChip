module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    reg state;
    parameter A = 1'b0, B = 1'b1;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: if (x) state <= B;
                   else state <= A;
                B: state <= B;
                default: state <= A;
            endcase
        end
    end

    always @(*) begin
        case (state)
            A: if (x) z = 1'b1;
               else z = 1'b0;
            B: if (!x) z = 1'b1;
               else z = 1'b0;
            default: z = 1'b0;
        endcase
    end
endmodule
