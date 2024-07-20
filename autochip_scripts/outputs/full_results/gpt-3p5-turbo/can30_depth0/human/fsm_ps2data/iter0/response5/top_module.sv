module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;
reg [23:0] temp_out_bytes;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done <= 1'b0;
    end else begin
        case (state)
            2'b00: begin
                if (in[3]) begin
                    state <= 2'b01;
                    byte1 <= in;
                end else begin
                    state <= 2'b00;
                end
            end
            2'b01: begin
                state <= 2'b10;
                byte2 <= in;
            end
            2'b10: begin
                state <= 2'b11;
                byte3 <= in;
            end
            2'b11: begin
                state <= 2'b00;
                byte1 <= in;
                temp_out_bytes <= {byte3, byte2, byte1};
                done <= 1'b1;
            end
            default: begin
                state <= 2'b00;
            end
        endcase
    end
end

assign out_bytes = done ? temp_out_bytes : 24'b0;

endmodule
