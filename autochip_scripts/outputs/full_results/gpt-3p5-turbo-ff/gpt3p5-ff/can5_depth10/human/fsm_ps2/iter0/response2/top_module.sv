module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg wait_for_byte1 = 1'b1;
reg wait_for_byte2;
reg wait_for_byte3;
reg done_reg = 1'b0;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        wait_for_byte1 <= 1'b1;
        wait_for_byte2 <= 1'b0;
        wait_for_byte3 <= 1'b0;
        done_reg <= 1'b0;
    end else begin
        byte1 <= in;
        byte2 <= byte1;
        byte3 <= byte2;
        
        if (wait_for_byte1) begin
            if (byte1[3] == 1'b1) begin
                wait_for_byte2 <= 1'b1;
                wait_for_byte1 <= 1'b0;
            end
        end else if (wait_for_byte2) begin
            wait_for_byte3 <= 1'b1;
            wait_for_byte2 <= 1'b0;
        end else if (wait_for_byte3) begin
            done_reg <= 1'b1;
            wait_for_byte3 <= 1'b0;
            wait_for_byte1 <= 1'b1;
        end
    end
end

assign done = done_reg;

endmodule
