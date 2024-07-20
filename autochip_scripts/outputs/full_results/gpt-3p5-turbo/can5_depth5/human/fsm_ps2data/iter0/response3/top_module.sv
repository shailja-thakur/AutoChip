module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [1:0] state;
reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;
wire byte_1_valid;
wire byte_2_valid;
wire byte_3_valid;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        byte_1 <= 8'b0;
        byte_2 <= 8'b0;
        byte_3 <= 8'b0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3] == 1) begin
                    state <= 2'b01;
                    byte_1 <= in;
                end
            end
            2'b01: begin
                state <= 2'b10;
                byte_2 <= in;
            end
            2'b10: begin
                state <= 2'b11;
                byte_3 <= in;
            end
            2'b11: begin
                if (in[3] == 1) begin
                    state <= 2'b01;
                    byte_1 <= in;
                end
            end
        endcase
    end
end

assign byte_1_valid = (state == 2'b01);
assign byte_2_valid = (state == 2'b10);
assign byte_3_valid = (state == 2'b11);

always @(*) begin
    if (byte_1_valid && byte_2_valid && byte_3_valid) begin
        done = 1;
    end else begin
        done = 0;
    end
end

assign out_bytes[23:16] = byte_1;
assign out_bytes[15:8] = byte_2;
assign out_bytes[7:0] = byte_3;

endmodule
