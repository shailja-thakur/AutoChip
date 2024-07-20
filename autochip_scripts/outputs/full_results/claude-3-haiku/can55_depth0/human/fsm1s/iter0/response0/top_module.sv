module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam A = 1'b0;
localparam B = 1'b1;

reg state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
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
        endcase
    end
end

endmodule
