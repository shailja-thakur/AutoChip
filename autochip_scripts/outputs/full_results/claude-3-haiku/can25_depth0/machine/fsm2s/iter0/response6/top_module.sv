module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state;
    parameter A = 1'b0, B = 1'b1;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (j) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    if (k) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                default: state <= A;
            endcase
        end
    end

    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule
