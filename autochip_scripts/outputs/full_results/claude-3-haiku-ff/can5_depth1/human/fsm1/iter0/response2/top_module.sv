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
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
                out <= 1'b1;
            end
            A: begin
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
