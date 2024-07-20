module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= B;
    else begin
        case (state)
            B: begin
                out <= 1'b1;
                if (in == 0)
                    state <= A;
                else
                    state <= B;
            end
            A: begin
                out <= 0;
                if (in == 0)
                    state <= B;
                else
                    state <= A;
            end
        endcase
    end
end

endmodule
