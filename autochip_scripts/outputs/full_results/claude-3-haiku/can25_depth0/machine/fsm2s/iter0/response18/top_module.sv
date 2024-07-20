module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg state;
    localparam A = 1'b0, B = 1'b1;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (j) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                end
                B: begin
                    if (k) begin
                        state <= A;
                    end
                    else begin
                        state <= B;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

endmodule
