module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000; // initial state A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case ({state, w})
        3'b0000: next_state = 3'b000; // A to A when w is 0
        3'b0001: next_state = 3'b001; // A to B when w is 1
        3'b0010: next_state = 3'b010; // B to C when w is 1
        3'b0011: next_state = 3'b110; // B to D when w is 0
        3'b0100: next_state = 3'b011; // C to E when w is 1
        3'b0101: next_state = 3'b110; // C to D when w is 0
        3'b0110: next_state = 3'b000; // D to A when w is 0
        3'b0111: next_state = 3'b111; // D to F when w is 1
        3'b1000: next_state = 3'b100; // E to E when w is 1
        3'b1001: next_state = 3'b110; // E to D when w is 0
        3'b1010: next_state = 3'b101; // F to C when w is 1
        3'b1011: next_state = 3'b110; // F to D when w is 0
        default: next_state = 3'b000;
    endcase
end

assign z = (state == 3'b100) | (state == 3'b101); // Set z to 1 when state is E or F

endmodule
