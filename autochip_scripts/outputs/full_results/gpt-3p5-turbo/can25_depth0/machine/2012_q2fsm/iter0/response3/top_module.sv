module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;  // initialize state to A
    else
        case (state)
            3'b000: state <= w ? 3'b001 : 3'b000;  // A -> B if w=1, stay in A if w=0
            3'b001: state <= w ? 3'b010 : 3'b100;  // B -> C if w=1, D if w=0
            3'b010: state <= w ? 3'b111 : 3'b100;  // C -> E if w=1, D if w=0
            3'b011: state <= w ? 3'b100 : 3'b000;  // D -> F if w=1, A if w=0
            3'b100: state <= w ? 3'b011 : 3'b011;  // E -> E if w=1, stay in E if w=0
            3'b101: state <= w ? 3'b010 : 3'b110;  // F -> C if w=1, D if w=0
            default: state <= 3'b000;  // default case
        endcase
end

// Output generation
assign z = (state == 3'b010) || (state == 3'b101);  // z is set to 1 when state is E or F

endmodule
