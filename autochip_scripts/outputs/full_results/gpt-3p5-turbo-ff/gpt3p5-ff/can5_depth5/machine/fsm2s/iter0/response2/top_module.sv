module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    reg [1:0] state;
    always @(posedge clk or posedge reset)
        if (reset)
            state <= 2'b00;
        else
            if (state == 2'b00) // State A
                if (j)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            else // State B
                if (k)
                    state <= 2'b00;
                else
                    state <= 2'b01;
    
    always @(posedge clk)
        if (state == 2'b01)
            out <= 1'b1;
        else
            out <= 1'b0;
    
endmodule
