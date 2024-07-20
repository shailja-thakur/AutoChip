module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;
    parameter B = 2'b00;
    parameter A = 2'b01;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end else begin
            case(state)
                B: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                A: begin
                    if (in) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                default: state <= B;
            endcase
        end
    end

    always @(state) begin
        case(state)
            B: out_reg = 1'b1;
            A: out_reg = 1'b0;
            default: out_reg = 1'b1;
        endcase
    end

    assign out = out_reg;

endmodule
