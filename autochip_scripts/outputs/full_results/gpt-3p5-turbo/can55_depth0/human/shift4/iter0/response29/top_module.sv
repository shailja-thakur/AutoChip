module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
    );
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0; // reset the shift register to zero
        end else if (load) begin
            q <= data; // load the shift register with data[3:0]
        end else if (ena) begin
            q[3] <= 1'b0; // shift right (q[3] becomes zero)
            q[2:0] <= q[3:1]; // shift the remaining bits to the right
        end
    end
    
endmodule
