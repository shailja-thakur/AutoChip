module top_module(
    input clk,
    input reset,
    output reg [2:0] state,
    output shift_ena);

    always @(posedge clk)
    begin
        if(reset)
            state <= 3'b000; // B0
        else if(state == 3'b000)
            state <= 3'b001; // B1
        else if(state == 3'b001)
            state <= 3'b010; // B2
        else if(state == 3'b010)
            state <= 3'b011; // B3
        else
            state <= 3'b100; // Done
    end

    assign shift_ena = (state != 3'b100) ? 1'b1 : 1'b0;

endmodule
