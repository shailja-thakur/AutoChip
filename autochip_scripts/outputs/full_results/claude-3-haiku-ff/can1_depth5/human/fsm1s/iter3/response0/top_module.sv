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
    end
    else begin
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
end

endmodule
