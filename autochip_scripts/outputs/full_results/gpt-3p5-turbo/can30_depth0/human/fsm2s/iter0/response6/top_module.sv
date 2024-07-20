module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            out <= 1'b0;
        end else begin
            case (state)
                2'b00:
                    begin
                        if (j) begin
                            state <= 2'b01;
                            out <= 1'b0;
                        end
                        else begin
                            state <= 2'b00;
                            out <= 1'b0;
                        end
                    end
                2'b01:
                    begin
                        if (k) begin
                            state <= 2'b00;
                            out <= 1'b1;
                        end
                        else begin
                            state <= 2'b01;
                            out <= 1'b1;
                        end
                    end
                default:
                    begin
                        state <= 2'b00;
                        out <= 1'b0;
                    end
            endcase
        end
    end

endmodule
