module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // reset state A
        z <= 0;
    end else begin
        case (state)
            2'b00: // state A
                if (s == 1)
                    state <= 2'b01; // move to state B
                else
                    state <= 2'b00; // stay in state A
            2'b01: // state B
                if (w == 1) begin
                    state <= 2'b10; // move to state C
                end else begin
                    state <= 2'b01; // stay in state B
                end
            2'b10: // state C
                if (w == 1) begin
                    state <= 2'b11; // move to state D
                end else begin
                    state <= 2'b01; // move back to state B
                end
            2'b11: // state D
                if (w == 1) begin
                    state <= 2'b11; // stay in state D
                end else begin
                    state <= 2'b00; // move back to state A
                    z <= 1; // set output z to 1
                end
        endcase
    end
end

endmodule
