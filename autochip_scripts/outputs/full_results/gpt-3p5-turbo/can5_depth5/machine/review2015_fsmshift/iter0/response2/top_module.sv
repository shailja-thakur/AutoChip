module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // B0
    else begin
        case (state)
            3'b000: state <= 3'b001; // B0 -> B1
            3'b001: state <= 3'b010; // B1 -> B2
            3'b010: state <= 3'b011; // B2 -> B3
            3'b011: state <= 3'b100; // B3 -> Done
            default: state <= 3'b100; // Any other state -> Done
        endcase
    end
end

// Shift enable logic
assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011);

endmodule
