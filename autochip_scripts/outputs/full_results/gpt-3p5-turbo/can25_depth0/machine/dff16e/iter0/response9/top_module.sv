module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    always @(posedge clk) begin
        if(!resetn) begin
            q <= 16'b0;  // Reset to 0 if resetn is low
        end else begin
            if(byteena[0]) begin
                q[7:0] <= d[7:0];  // Write lower 8 bits of d to lower 8 bits of q if byteena[0] is high
            end
            if(byteena[1]) begin
                q[15:8] <= d[15:8];  // Write upper 8 bits of d to upper 8 bits of q if byteena[1] is high
            end
        end
    end

endmodule
