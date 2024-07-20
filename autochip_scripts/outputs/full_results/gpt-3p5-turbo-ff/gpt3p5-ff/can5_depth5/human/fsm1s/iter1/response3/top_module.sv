module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge reset)
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

    always @(state)
    begin
        case (state)
            2'b10: out = 1'b1;  // B state
            2'b01: out = 1'b0;  // A state
        endcase
    end

endmodule
