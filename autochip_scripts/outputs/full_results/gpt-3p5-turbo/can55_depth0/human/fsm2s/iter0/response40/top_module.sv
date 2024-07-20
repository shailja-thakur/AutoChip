module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
 
reg [1:0] state;
 
always @(posedge clk, posedge reset)
begin
    if (reset)
        state <= 2'b0;
    else
    begin
        case (state)
            2'b00: // OFF
            begin
                if (j)
                    state <= 2'b01; // Transition to ON state
                else
                    state <= 2'b00; // Stay in OFF state
            end
            2'b01: // ON
            begin
                if (k)
                    state <= 2'b00; // Transition to OFF state
                else
                    state <= 2'b01; // Stay in ON state
            end
        endcase
    end
end
 
assign out = (state == 2'b01) ? 1'b1 : 1'b0;
 
endmodule
