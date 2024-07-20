module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;
reg out;

always @(posedge clk or posedge areset)
    if (areset)
        state <= 2'b00;
    else
        state <= next_state;

always @(state, in)
    case (state)
        2'b00:
            begin
                if (in)
                    next_state = 2'b10;
                else
                    next_state = 2'b01;
                out = 1'b0;
            end
        2'b01:
            begin
                if (in)
                    next_state = 2'b00;
                else
                    next_state = 2'b01;
                out = 1'b0;
            end
        2'b10:
            begin
                if (in)
                    next_state = 2'b10;
                else
                    next_state = 2'b11;
                out = 1'b0;
            end
        2'b11:
            begin
                if (in)
                    next_state = 2'b01;
                else
                    next_state = 2'b10;
                out = 1'b1;
            end
    end

endmodule
