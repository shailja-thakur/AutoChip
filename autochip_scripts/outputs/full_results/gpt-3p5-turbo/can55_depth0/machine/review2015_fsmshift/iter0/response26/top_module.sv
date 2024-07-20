module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state
);

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: state <= 3'b001; // B0 -> B1
            3'b001: state <= 3'b010; // B1 -> B2
            3'b010: state <= 3'b011; // B2 -> B3
            3'b011: state <= 3'b100; // B3 -> Done
            default: state <= 3'b100; // Done
        endcase
    end
end

assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
