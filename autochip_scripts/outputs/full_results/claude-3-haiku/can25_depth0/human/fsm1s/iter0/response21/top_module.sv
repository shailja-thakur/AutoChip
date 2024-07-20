module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk or posedge reset) begin
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
            default: begin
                state <= B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
