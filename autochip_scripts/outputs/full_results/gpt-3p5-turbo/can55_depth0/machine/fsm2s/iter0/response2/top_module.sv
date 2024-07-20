module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00; // state A
        else if (state == 2'b00)
            state <= (j) ? 2'b01 : 2'b00; // next state is B if j is high, else A
        else if (state == 2'b01)
            state <= (k) ? 2'b00 : 2'b01; // next state is A if k is high, else B
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output is high when state is B, else low
    
endmodule
