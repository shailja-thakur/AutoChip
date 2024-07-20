module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;  // reset to state A
        else begin
            case (state)
                2'b00: begin  // state A
                    if (in)
                        state <= 2'b01;  // next state B
                    else
                        state <= 2'b00;  // next state A
                    out <= 1'b0;  // output 0
                end
                
                2'b01: begin  // state B
                    if (in)
                        state <= 2'b01;  // next state B
                    else
                        state <= 2'b10;  // next state C
                    out <= 1'b0;  // output 0
                end
                
                2'b10: begin  // state C
                    if (in)
                        state <= 2'b11;  // next state D
                    else
                        state <= 2'b00;  // next state A
                    out <= 1'b0;  // output 0
                end
                
                2'b11: begin  // state D
                    if (in)
                        state <= 2'b10;  // next state C
                    else
                        state <= 2'b01;  // next state B
                    out <= 1'b1;  // output 1
                end
            endcase
        end
    end
    
endmodule
