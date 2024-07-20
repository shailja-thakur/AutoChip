module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state;
localparam A = 1'b0, B = 1'b1;

always @(posedge clk) begin
    if (reset)
        state <= B;
    else
        case (state)
            B: begin
                out <= 1'b1;
                if (in)
                    state <= B;
                else
                    state <= A;
            end
            A: begin
                out <= 1'b0;
                if (in)
                    state <= A;
                else
                    state <= B;
            end
        endcase
end

endmodule
