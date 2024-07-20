module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else if (state < 3'b100)
            state <= state + 1;
        else
            state <= 3'b100;
    end

    // shift_ena logic
    assign shift_ena = (state < 3'b100);

endmodule
