module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
	
reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // searching for byte 1
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                end
            end
            1: begin // searching for byte 2
                if (in[3] == 1) begin
                    byte2 <= in;
                    state <= 2;
                end
            end
            2: begin // searching for byte 3
                if (in[3] == 1) begin
                    byte3 <= in;
                    state <= 3;
                end
            end
            3: begin // message received
                out_bytes[23:16] <= byte1;
                out_bytes[15:8] <= byte2;
                out_bytes[7:0] <= byte3;
                done <= 1;
                state <= 0;
            end
        endcase
    end
end

endmodule
