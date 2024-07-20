module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // B0
    end
    else begin
        case (state)
            3'b000: state <= 3'b001; // B0 -> B1
            3'b001: state <= 3'b010; // B1 -> B2
            3'b010: state <= 3'b011; // B2 -> B3
            3'b011: state <= 3'b100; // B3 -> Done
            3'b100: state <= 3'b000; // Done -> B0
            default: state <= 3'b100; // Any other state -> Done
        endcase
    end
end

always @(*) begin
    if (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) begin
        shift_ena = 1'b1;
    end
    else begin
        shift_ena = 1'b0;
    end
end

endmodule
