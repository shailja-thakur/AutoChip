module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk)
    begin
        if (reset)
            state <= 2'b10;  // B state
        else if (state == 2'b10)  // B state
        begin
            if (in)
                state <= 2'b10;  // B state
            else
                state <= 2'b01;  // A state
        end
        else if (state == 2'b01)  // A state
        begin
            if (in)
                state <= 2'b01;  // A state
            else
                state <= 2'b10;  // B state
        end
    end

    always @*
    begin
        if (state == 2'b10)  // B state
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
