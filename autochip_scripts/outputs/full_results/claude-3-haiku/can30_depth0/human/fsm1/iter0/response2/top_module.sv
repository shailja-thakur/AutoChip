module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            B:
                if (in) begin
                    state <= B;
                    out <= 1'b1;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
                end
            A:
                if (in) begin
                    state <= A;
                    out <= 1'b0;
                end
                else begin
                    state <= B;
                    out <= 1'b1;
                end
        endcase
    end
end

endmodule
