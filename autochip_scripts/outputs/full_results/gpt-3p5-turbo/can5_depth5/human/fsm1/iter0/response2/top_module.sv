module top_module (
    input clk,
    input in,
    input areset,
    output out
);
    
    reg [1:0] state;
    
    always @(posedge clk or posedge areset)
        if (areset)
            state <= 2'b1; // Reset to state B
        else if (state == 2'b00)
            state <= in ? 2'b00 : 2'b01;
        else if (state == 2'b01)
            state <= in ? 2'b11 : 2'b10;
        else if (state == 2'b10)
            state <= in ? 2'b01 : 2'b00;
        else if (state == 2'b11)
            state <= in ? 2'b11 : 2'b10;
    
    always @(state)
        case (state)
            2'b00: out = 1'b0;
            2'b01: out = 1'b0;
            2'b10: out = 1'b1;
            2'b11: out = 1'b1;
        endcase
    
endmodule
