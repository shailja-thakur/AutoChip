module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // Reset to state A
    end else begin
        case (state)
            3'b000: if (w) state <= 3'b000; else state <= 3'b001; // Transition from A to A if w is high, else B
            3'b001: if (w) state <= 3'b010; else state <= 3'b011; // Transition from B to D if w is high, else C
            3'b010: if (w) state <= 3'b011; else state <= 3'b101; // Transition from C to D if w is high, else E
            3'b011: if (w) state <= 3'b000; else state <= 3'b110; // Transition from D to A if w is high, else F
            3'b101: if (w) state <= 3'b010; else state <= 3'b101; // Transition from E to D if w is high, else E
            3'b110: if (w) state <= 3'b011; else state <= 3'b011; // Transition from F to D if w is high, else C
            default: state <= 3'b000;
        endcase
    end
end

always @(state) begin
    if (state == 3'b101 || state == 3'b110) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
