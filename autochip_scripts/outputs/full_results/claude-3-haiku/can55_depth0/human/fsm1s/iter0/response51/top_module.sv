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
    end
    else begin
        case (state)
            B: begin
                out <= 1'b1;
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            A: begin
                out <= 1'b0;
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
        endcase
    end
end

endmodule
