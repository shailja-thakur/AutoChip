module top_module(
    input clk,
    input reset,
    output shift_ena);

    // State register
    reg [2:0] state;
    
    // Clocked logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b0;
        else if (state == 3'b0)
            state <= 3'b1;
        else if (state == 3'b1)
            state <= 3'b2;
        else if (state == 3'b2)
            state <= 3'b3;
        else if (state == 3'b3)
            state <= 3'bDone;
        else
            state <= 3'bDone;
    end
    
    // Combinational logic to determine shift_ena
    assign shift_ena = (state != 3'bDone && !reset);

endmodule
