module top_module (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);
    
    reg [7:0] q_next; // intermediate register for storing the next value of q

    always @(posedge clk) begin
        q_next <= d; // store the value of d in the intermediate register on the positive edge of clk
    end
    
    always @(posedge clk) begin
        q <= q_next; // update the value of q with the value from the intermediate register on the positive edge of clk
    end
endmodule
