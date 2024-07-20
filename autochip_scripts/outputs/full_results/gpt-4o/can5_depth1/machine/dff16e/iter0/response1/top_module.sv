module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);
    
    // Always block triggered on the positive edge of the clock or negative edge of resetn
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Asynchronous reset
            q <= 16'b0;
        end
        else begin
            // Byte enable handling
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
        end
    end
    
endmodule
