module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        out_bytes <= 24'b0;
        done <= 0;
    end else begin
        case (state)
            2'b00: begin // Discard bytes until in[3] = 1
                if (in[3]) begin
                    byte1 <= in;
                    state <= 2'b01;
                end
            end
            2'b01: begin // Receive byte 2
                byte2 <= in;
                state <= 2'b10;
            end
            2'b10: begin // Receive byte 3
                byte3 <= in;
                state <= 2'b00;
                done <= 1;
            end
        endcase
    end
end

assign out_bytes = {byte1, byte2, byte3};

endmodule
