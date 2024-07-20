module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset)
            state <= 2'b1;
        else
            state <= (state == 2'b00 && in) ? 2'b00 : (state == 2'b00 && !in) ? 2'b01 : (state == 2'b01 && in) ? 2'b01 : (state == 2'b01 && !in) ? 2'b00 : 2'b00;
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
