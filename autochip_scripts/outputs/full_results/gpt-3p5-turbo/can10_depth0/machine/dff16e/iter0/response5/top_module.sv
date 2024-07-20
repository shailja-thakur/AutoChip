module top_module(
    input CLK,
    input RSTN,
    input [1:0] BYTEENA,
    input [15:0] D,
    output reg [15:0] Q);
    
    always @(posedge CLK) begin
        if (!RSTN) begin
            Q <= 16'b0;
        end else begin
            if (BYTEENA[0]) begin
                Q[7:0] <= D[7:0];
            end
            if (BYTEENA[1]) begin
                Q[15:8] <= D[15:8];
            end
        end
    end
    
endmodule
