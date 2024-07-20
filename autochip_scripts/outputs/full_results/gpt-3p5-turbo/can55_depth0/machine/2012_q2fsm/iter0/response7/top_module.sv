module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or negedge reset) begin
    if (reset == 0)
        state <= 3'b000; // Initial state is A
    else if (w == 0) begin
        case (state)
            3'b000: state <= 3'b000; // A to A
            3'b001: state <= 3'b100; // B to D
            3'b010: state <= 3'b100; // C to D
            3'b011: state <= 3'b000; // D to A
            3'b100: state <= 3'b010; // E to D
            3'b101: state <= 3'b010; // F to D
        endcase
    end else begin
        case (state)
            3'b000: state <= 3'b001; // A to B
            3'b001: state <= 3'b010; // B to C
            3'b010: state <= 3'b100; // C to E
            3'b011: state <= 3'b101; // D to F
            3'b100: state <= 3'b100; // E to E
            3'b101: state <= 3'b010; // F to C
        endcase
    end
end

assign z = (state == 3'b100) || (state == 3'b101); // z is 1 when state is E or F

endmodule
