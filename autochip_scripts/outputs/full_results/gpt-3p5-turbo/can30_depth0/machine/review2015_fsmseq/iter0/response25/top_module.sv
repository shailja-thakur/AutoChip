module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;  // state register

always @(posedge clk, posedge reset)
    if (reset)
        state <= 3'b000;  // initial state S
    else
        case (state)
            3'b000: if (data) state <= 3'b001; else state <= 3'b000;  // S
            3'b001: if (data) state <= 3'b011; else state <= 3'b000;  // S1
            3'b011: if (data) state <= 3'b011; else state <= 3'b110;  // S11
            3'b110: if (data) state <= 3'b111; else state <= 3'b000;  // S110
            3'b111: state <= 3'b111;  // Done
            default: state <= 3'b000;
        endcase

assign start_shifting = (state == 3'b111) ? 1'b1 : 1'b0;

endmodule
