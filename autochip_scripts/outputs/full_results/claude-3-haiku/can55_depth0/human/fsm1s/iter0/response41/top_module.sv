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
            A: begin
                out <= 1'b0;
                if (in == 1'b0) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                out <= 1'b1;
                if (in == 1'b0) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
        endcase
    end
end

endmodule
