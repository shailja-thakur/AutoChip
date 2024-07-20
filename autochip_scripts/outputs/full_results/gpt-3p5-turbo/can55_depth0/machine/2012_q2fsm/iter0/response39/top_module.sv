module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initial state is A
    else begin
        case (state)
            3'b000: // State A
                state <= (w == 1'b1) ? 3'b001 : 3'b000;
            3'b001: // State B
                state <= (w == 1'b1) ? 3'b010 : 3'b011;
            3'b010: // State C
                state <= (w == 1'b1) ? 3'b110 : 3'b001;
            3'b011: // State D
                state <= (w == 1'b1) ? 3'b111 : 3'b000;
            3'b100: // State E
                state <= (w == 1'b1) ? 3'b100 : 3'b011;
            3'b101: // State F
                state <= (w == 1'b1) ? 3'b011 : 3'b010;
        endcase
    end
end

assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
