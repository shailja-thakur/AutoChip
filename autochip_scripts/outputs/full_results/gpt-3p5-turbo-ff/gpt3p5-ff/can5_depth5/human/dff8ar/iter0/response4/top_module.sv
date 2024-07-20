module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);

    reg [7:0] q_temp; // Temporary register for storing intermediate values
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q_temp <= 8'b0; // Reset all flip-flops to 0
        end else begin
            q_temp <= d; // Assign input to temporary register
        end
    end
    
    always @(posedge clk) begin
        if (!areset) begin
            q <= q_temp; // Assign temporary register to output
        end
    end
endmodule
