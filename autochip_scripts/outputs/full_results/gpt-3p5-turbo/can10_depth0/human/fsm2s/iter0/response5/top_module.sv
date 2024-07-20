module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;

// Define state values
parameter OFF = 2'b00;
parameter ON = 2'b01;

always @ (posedge clk or posedge reset)
begin
    if (reset) // Synchronous reset
        state <= OFF;
    else
    begin
        case(state)
            OFF:
                if (j)
                    state <= ON;
                else
                    state <= OFF;
            ON:
                if (k)
                    state <= OFF;
                else
                    state <= ON;
        endcase
    end
end

always @(state)
begin
    case(state)
        OFF:
            out = 0;
        ON:
            out = 1;
    endcase
end

endmodule
