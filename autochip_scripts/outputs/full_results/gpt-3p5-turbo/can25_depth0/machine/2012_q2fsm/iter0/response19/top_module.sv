module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
assign z = (state == 3'b110) || (state == 3'b111);

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;  // Reset state to A
    else begin
        case ({state, w})
            3'b0000: state <= 3'b000;  // A to A
            3'b0001: state <= 3'b001;  // A to B
            3'b0010: state <= 3'b010;  // B to C
            3'b0011: state <= 3'b101;  // B to D
            3'b0100: state <= 3'b011;  // C to E
            3'b0101: state <= 3'b111;  // C to F
            3'b0110: state <= 3'b101;  // D to E
            3'b0111: state <= 3'b111;  // D to F
            3'b1000: state <= 3'b000;  // E to A
            3'b1001: state <= 3'b001;  // E to B
            3'b1010: state <= 3'b011;  // E to C
            3'b1011: state <= 3'b111;  // E to F
            3'b1100: state <= 3'b001;  // F to B
            3'b1101: state <= 3'b010;  // F to C
            3'b1110: state <= 3'b110;  // F to D
            3'b1111: state <= 3'b011;  // F to E
        endcase
    end
end
endmodule
