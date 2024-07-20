module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state;
wire clk_edge;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else if (clk_edge)
        case (state)
            3'b000: state <= w ? 3'b000 : 3'b001;
            3'b001: state <= w ? 3'b001 : 3'b000;
            3'b010: state <= w ? 3'b010 : 3'b011;
            3'b011: state <= w ? 3'b011 : 3'b011;
            3'b100: state <= w ? 3'b100 : 3'b101;
            3'b101: state <= w ? 3'b110 : 3'b000;
            3'b110: state <= w ? 3'b111 : 3'b011;
            3'b111: state <= w ? 3'b010 : 3'b011;
            default: state <= 3'b000;
        endcase
end

assign clk_edge = clk & ~reset;

always @(state) begin
    case (state)
        3'b000: z = 1'b0; // Output Z when state is A (0)
        3'b001: z = 1'b1; // Output Z when state is B (0)
        3'b010: z = 1'b0; // Output Z when state is C (0)
        3'b011: z = 1'b1; // Output Z when state is D (0)
        3'b100: z = 1'b0; // Output Z when state is E (1)
        3'b101: z = 1'b1; // Output Z when state is F (1)
        3'b110: z = 1'b0; // Output Z when state is E (1)
        3'b111: z = 1'b1; // Output Z when state is F (1)
        default: z = 1'b0;
    endcase
end

endmodule
