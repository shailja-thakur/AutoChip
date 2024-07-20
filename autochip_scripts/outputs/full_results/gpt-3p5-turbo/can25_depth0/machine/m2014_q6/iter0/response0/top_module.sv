module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State declaration
reg [2:0] state;

// State machine transitions
always @(posedge clk) begin
    if (reset) begin
        state <= 3'd0; // Reset to state A
    end else begin
        case (state)
            3'b000: if (w) state <= 3'b000; else state <= 3'b001; // A to A or A to B
            3'b001: if (w) state <= 3'b101; else state <= 3'b010; // B to D or B to C
            3'b010: if (w) state <= 3'b011; else state <= 3'b010; // C to D or C to C
            3'b011: if (w) state <= 3'b000; else state <= 3'b100; // D to A or D to F
            3'b100: if (w) state <= 3'b010; else state <= 3'b100; // F to C or F to F
            3'b101: if (w) state <= 3'b010; else state <= 3'b110; // E to D or E to E
            3'b110: if (w) state <= 3'b011; else state <= 3'b110; // E to D or E to E
        endcase
    end
end

// Output assignment
always @(state) begin
    if (state == 3'b101 || state == 3'b100) begin
        z <= 1'b1; // State E or F
    end else begin
        z <= 1'b0; // Other states
    end
end

endmodule
