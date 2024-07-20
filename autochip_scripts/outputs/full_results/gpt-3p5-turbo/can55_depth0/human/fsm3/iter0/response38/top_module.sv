module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or negedge areset)
    begin
        if (areset == 0)
            state <= A;
        else
        begin
            case (state)
                A: state <= (in == 1) ? B : A;
                B: state <= (in == 1) ? B : C;
                C: state <= (in == 1) ? D : A;
                D: state <= (in == 1) ? B : C;
                default: state <= A;
            endcase
        end
    end

    always @(state)
    begin
        case (state)
            A: out_reg = 1'b0;
            D: out_reg = 1'b1;
            default: out_reg = 1'b0;
        endcase
    end

    assign out = out_reg;

endmodule
