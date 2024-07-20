module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
reg [7:0] temp_byte1, temp_byte2, temp_byte3;
wire start_packet;

assign start_packet = (byte1[3] == 1'b1);

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
        byte1 <= 8'h00;
        byte2 <= 8'h00;
        byte3 <= 8'h00;
    end else begin
        case(state)
            3'b000: begin
                byte1 <= in;
                if (start_packet) begin
                    state <= 3'b001;
                    temp_byte1 <= byte1;
                end
            end
            3'b001: begin
                byte2 <= in;
                state <= 3'b010;
                temp_byte2 <= byte2;
            end
            3'b010: begin
                byte3 <= in;
                state <= 3'b011;
                temp_byte3 <= byte3;
            end
            3'b011: begin
                state <= 3'b100;
            end
            3'b100: begin
                byte1 <= temp_byte1;
                byte2 <= temp_byte2;
                byte3 <= temp_byte3;
                done <= 1'b1;
                state <= 3'b101;
            end
            3'b101: begin
                done <= 1'b0;
                state <= 3'b000;
            end
        endcase
    end
end

assign out_bytes = {byte3, byte2, byte1};

endmodule
