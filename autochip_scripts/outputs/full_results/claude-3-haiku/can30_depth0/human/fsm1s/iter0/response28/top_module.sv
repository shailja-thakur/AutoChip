module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state; // 0 = state A, 1 = state B

always @(posedge clk) begin
    if (reset) begin
        state <= 1'b1; // reset state is B
        out <= 1'b1;
    end
    else begin
        case (state)
            1'b0: // state A
                if (in) begin
                    state <= 1'b0; // A --in=1--> A
                    out <= 1'b0;
                end
                else begin
                    state <= 1'b1; // A --in=0--> B
                    out <= 1'b0;
                end
            1'b1: // state B
                if (in) begin
                    state <= 1'b1; // B --in=1--> B
                    out <= 1'b1;
                end
                else begin
                    state <= 1'b0; // B --in=0--> A
                    out <= 1'b1;
                end
        endcase
    end
end

endmodule
