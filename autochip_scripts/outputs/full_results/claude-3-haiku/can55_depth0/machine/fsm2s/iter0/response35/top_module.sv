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
            out <= 1'b0;
        end
        else begin
            case (state)
                A: begin
                    if (j) begin
                        state <= B;
                        out <= 1'b1;
                    end
                    else begin
                        state <= A;
                        out <= 1'b0;
                    end
                end
                B: begin
                    if (k) begin
                        state <= A;
                        out <= 1'b0;
                    end
                    else begin
                        state <= B;
                        out <= 1'b1;
                    end
                end
            endcase
        end
    end

endmodule
