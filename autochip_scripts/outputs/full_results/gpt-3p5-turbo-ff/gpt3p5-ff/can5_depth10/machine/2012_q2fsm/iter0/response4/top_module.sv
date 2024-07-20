module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // initial state A
    else begin
        case (state)
            3'b000 : if (w) state <= 3'b001; else state <= 3'b000; // A to B or A to A
            3'b001 : if (w) state <= 3'b010; else state <= 3'b011; // B to C or B to D
            3'b010 : if (w) state <= 3'b110; else state <= 3'b011; // C to E or C to D
            3'b011 : if (w) state <= 3'b111; else state <= 3'b000; // D to F or D to A
            3'b110 : if (w) state <= 3'b110; else state <= 3'b010; // E to E or E to C
            3'b111 : if (w) state <= 3'b010; else state <= 3'b011; // F to C or F to D
            default : state <= 3'b000; // default to A
        endcase
    end
end

assign z = (state == 3'b110) || (state == 3'b111); // output z is 1 when in state E or F

endmodule
