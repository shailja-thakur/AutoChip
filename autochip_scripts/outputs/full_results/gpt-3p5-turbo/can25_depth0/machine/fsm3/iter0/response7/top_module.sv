module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00; // reset to state A
        else begin
            case (state)
                // State A
                2'b00: begin
                    if (in)
                        state <= 2'b01; // next state B
                    else
                        state <= 2'b00; // next state A
                end
                
                // State B
                2'b01: begin
                    if (in)
                        state <= 2'b01; // next state B
                    else
                        state <= 2'b10; // next state C
                end
                
                // State C
                2'b10: begin
                    if (in)
                        state <= 2'b11; // next state D
                    else
                        state <= 2'b00; // next state A
                end
                
                // State D
                2'b11: begin
                    if (in)
                        state <= 2'b01; // next state B
                    else
                        state <= 2'b10; // next state C
                end
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0; // output is 1 when in state D

endmodule
