module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk)
    begin
        if (reset)
            state <= 2'b10;  // B state
        else if (state == 2'b10)  // B state
            state <= (in) ? 2'b10 : 2'b01;  // B or A state
        else if (state == 2'b01)  // A state
            state <= (in) ? 2'b01 : 2'b10;  // A or B state
    end

    always @*
    begin
        case (state)
            2'b10: out_reg = 1'b1;  // B state, output is 1
            2'b01: out_reg = 1'b0;  // A state, output is 0
        endcase
    end

    assign out = out_reg;

endmodule
