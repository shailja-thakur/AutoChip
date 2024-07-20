module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state, next_state;

    parameter OFF = 2'b00;
    parameter ON  = 2'b01;

    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= OFF;
        else
            state <= next_state;
    end

    always @(state, j, k)
    begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
                out <= 0;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
                out <= 1;
            end
        endcase
    end

endmodule
