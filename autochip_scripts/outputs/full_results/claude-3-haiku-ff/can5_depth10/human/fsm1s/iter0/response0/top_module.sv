module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            B: begin
                if (in == 1'b0) begin
                    state <= A;
                    out <= 1'b0;
                end
                else begin
                    state <= B;
                    out <= 1'b1;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    state <= B;
                    out <= 1'b1;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
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
