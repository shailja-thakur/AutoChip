module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [7:0] byte0;
reg [7:0] byte1;
reg [7:0] byte2;
reg [23:0] message;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        byte0 <= 0;
        byte1 <= 0;
        byte2 <= 0;
        message <= 0;
    end
    else begin
        byte0 <= in;
        byte1 <= byte0;
        byte2 <= byte1;
        if (byte2[3] == 1) begin
            message <= {byte2, byte1, byte0};
        end
    end
end

assign out_bytes = message;
assign done = (byte2[3] == 1);

endmodule
