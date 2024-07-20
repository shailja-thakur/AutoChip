module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    reg [4:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 5'b1;
        end else begin
            state <= {state[3] ^ state[2], state[4:1]};
        end
    end
    
    assign q = state;
    
endmodule
