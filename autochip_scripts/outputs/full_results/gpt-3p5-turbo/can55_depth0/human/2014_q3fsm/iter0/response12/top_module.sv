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
    end else begin
        case (state)
            2'b00: begin // state A
                if (s) begin
                    state <= 2'b01; // move to state B if s = 1
                end
            end
            2'b01: begin // state B
                if (w && w) begin // check if w = 1 in exactly two clock cycles
                    state <= 2'b10; // move to state C
                    z <= 1; // set output z to 1
                else
                    state <= 2'b00; // move back to state A
                    z <= 0; // set output z to 0
                end
            end
            2'b10: begin // state C
                state <= 2'b11; // move to state D
            end
            2'b11: begin // state D
                state <= 2'b00; // move back to state A
            end
        endcase
    end
end

endmodule
