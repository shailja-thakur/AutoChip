module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam A = 1'b0;
localparam B = 1'b1;

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
            default: begin
                state <= B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
