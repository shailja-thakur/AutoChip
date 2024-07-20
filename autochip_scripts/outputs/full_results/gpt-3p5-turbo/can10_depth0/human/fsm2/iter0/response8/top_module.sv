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
        if (areset)
            state <= 0;
        else begin
            case (state)
                0: begin
                    if (j)
                        state <= 1;
                    else
                        state <= 0;
                end
                1: begin
                    if (k)
                        state <= 0;
                    else
                        state <= 1;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            0: out <= 0;
            1: out <= 1;
        endcase
    end

endmodule
