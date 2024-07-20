module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b0;
        else
            case (state)
                2'b00: if (j)       state <= 2'b01;
                2'b01: if (~k)     state <= 2'b01;
                2'b01: if (k)      state <= 2'b00;
                2'b10: if (~j)     state <= 2'b10;
                2'b10: if (j)      state <= 2'b11;
                2'b11: if (~k)     state <= 2'b10;
                2'b11: if (k)      state <= 2'b00;
                default: state <= 2'b0;
            endcase
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
