module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State definitions
    parameter A = 1'b0;
    parameter B = 1'b1;

    // Internal state register
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            state <= B;
            out <= 1'b1;
        end
        else begin
            case (state)
                B: begin
                    if (in) begin
                        state <= B;
                        out <= 1'b1;
                    end
                    else begin
                        state <= A;
                        out <= 1'b1;
                    end
                end
                A: begin
                    if (in) begin
                        state <= A;
                        out <= 1'b0;
                    end
                    else begin
                        state <= B;
                        out <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
