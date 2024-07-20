module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;  // Reset to state A
    end else begin
        case (state)
            3'b000: if (w) state <= 3'b000; else state <= 3'b001;  // A to A if w is high, A to B if w is low
            3'b001: if (w) state <= 3'b010; else state <= 3'b011;  // B to D if w is high, B to C if w is low
            3'b010: if (w) state <= 3'b011; else state <= 3'b101;  // C to D if w is high, C to E if w is low
            3'b011: if (w) state <= 3'b000; else state <= 3'b110;  // D to A if w is high, D to F if w is low
            3'b101: if (w) state <= 3'b010; else state <= 3'b101;  // E to D if w is high, E to E if w is low
            3'b110: if (w) state <= 3'b011; else state <= 3'b010;  // F to D if w is high, F to C if w is low
            default: state <= 3'b000;
        endcase
    end
end

always @(state) begin
    if (state == 3'b101 || state == 3'b110) begin
        z <= 1'b1;  // Output z is high when state is E or F
    end else begin
        z <= 1'b0;
    end
end

endmodule
