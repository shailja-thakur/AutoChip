module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);

    // State register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 3'b000; // B0
        else if (state != 3'b100) // Done
            state <= state + 1;
    end

    // shift_ena assignment
    assign shift_ena = (state != 3'b100);

endmodule
