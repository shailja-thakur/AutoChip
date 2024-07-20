module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    reg [15:0] q_reg; // Register to hold the current state of q
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q_reg <= 16'b0; // Reset the output to 0
        end else if (byteena[1]) begin
            q_reg[15:8] <= d[15:8]; // Write to the upper byte if byteena[1] is high
        end else if (byteena[0]) begin
            q_reg[7:0] <= d[7:0]; // Write to the lower byte if byteena[0] is high
        end
    end
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q <= 16'b0; // Reset the output to 0
        end else begin
            q <= q_reg; // Update the output with the current state of q_reg
        end
    end
endmodule
