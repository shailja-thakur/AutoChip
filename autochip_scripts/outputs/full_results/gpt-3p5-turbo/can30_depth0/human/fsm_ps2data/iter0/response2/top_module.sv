module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        byte1 <= in;
        if (byte1[3] == 1) begin
            
            byte2 <= in;
            byte3 <= in;
            out_bytes <= {byte1, byte2, byte3};
            done <= 1;
        end
    end
end
endmodule
