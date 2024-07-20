module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
parameter A = 0, B = 1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            A: begin
                out <= 1'b0;
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                out <= 1'b1;
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            default: begin
                state <= B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
