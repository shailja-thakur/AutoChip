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
            state <= 2'b00;  // state A
        else if (state == 2'b00) begin  // state A
            if (j)
                state <= 2'b01;  // next state B
            else
                state <= 2'b00;  // next state A
        end else if (state == 2'b01) begin  // state B
            if (k)
                state <= 2'b00;  // next state A
            else
                state <= 2'b01;  // next state B
        end
    end
    
    assign out = (state == 2'b01);
    
endmodule
