module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
            out <= 1'b0;
        end else begin
            case (state)
                2'b00:
                    if (j == 1'b0)
                        state <= 2'b00;
                    else
                        state <= 2'b01;
                2'b01:
                    if (k == 1'b0)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                default:
                    state <= 2'b00;
            endcase
            case (state)
                2'b00: out <= 1'b0;
                2'b01: out <= 1'b1;
            endcase
        end
    end
endmodule
