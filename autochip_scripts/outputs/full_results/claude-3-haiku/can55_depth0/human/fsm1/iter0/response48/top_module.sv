module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= B;
    else begin
        case (state)
            B: begin
                if (in)
                    state <= B;
                else
                    state <= A;
            end
            A: begin
                if (in)
                    state <= A;
                else
                    state <= B;
            end
        endcase
    end
end

assign out = state;

endmodule
