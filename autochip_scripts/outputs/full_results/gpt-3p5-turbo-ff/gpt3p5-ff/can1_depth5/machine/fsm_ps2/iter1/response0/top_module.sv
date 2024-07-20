module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 3'b000;
    else
        case (state)
            3'b000: // BYTE1 state
                begin
                    if (in[2] == 1)
                        state <= 3'b001; // Transition to BYTE2 state
                    else
                        state <= 3'b000; // Remain in BYTE1 state
                end
            3'b001: // BYTE2 state
                state <= 3'b010; // Transition to BYTE3 state
            3'b010: // BYTE3 state
                state <= 3'b011; // Transition to DONE state
            3'b011: // DONE state
                begin
                    if (in[2] == 1)
                        state <= 3'b001; // Transition to BYTE2 state
                    else
                        state <= 3'b000; // Transition to BYTE1 state
                end
        endcase
end

assign done = (state == 3'b011);

endmodule
