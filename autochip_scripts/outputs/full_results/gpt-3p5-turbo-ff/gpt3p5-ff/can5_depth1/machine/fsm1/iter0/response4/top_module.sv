module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk, posedge areset)
begin
    if (areset)
        state <= 2'b0;
    else
        state <= next_state;
end

always @(*)
begin
    case(state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b00;
            else
                next_state = 2'b01;
        end
        
        2'b01: begin // State B
            if (in)
                next_state = 2'b01;
            else
                next_state = 2'b00;
        end
    endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
