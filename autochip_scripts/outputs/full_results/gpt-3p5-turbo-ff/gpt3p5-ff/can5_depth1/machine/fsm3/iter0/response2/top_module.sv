module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk)
    begin
        if (areset)
            state <= 2'b00; // reset to state A
        else
        begin
            case(state)
                2'b00: // state A
                    if (in)
                        state <= 2'b01; // next state B
                    else
                        state <= 2'b00; // next state A
                2'b01: // state B
                    if (in)
                        state <= 2'b01; // next state B
                    else
                        state <= 2'b10; // next state C
                2'b10: // state C
                    if (in)
                        state <= 2'b11; // next state D
                    else
                        state <= 2'b00; // next state A
                2'b11: // state D
                    if (in)
                        state <= 2'b01; // next state B
                    else
                        state <= 2'b10; // next state C
            endcase
        end
    end
    
    always @(posedge clk)
    begin
        if (state == 2'b11) // state D
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
