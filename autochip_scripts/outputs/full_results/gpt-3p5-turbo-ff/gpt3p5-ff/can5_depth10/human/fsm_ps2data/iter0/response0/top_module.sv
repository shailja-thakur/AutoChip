module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
        out_bytes <= 24'd0;
        done <= 0;
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: begin // Waiting for first byte
                if (in[3] == 1) begin
                    out_bytes[23:16] <= in;
                    state <= 3'b001;
                end
            end
            3'b001: begin // Waiting for second byte
                out_bytes[15:8] <= in;
                state <= 3'b010;
            end
            3'b010: begin // Waiting for third byte
                out_bytes[7:0] <= in;
                state <= 3'b011;
            end
            3'b011: begin // Waiting to signal done
                done <= 1;
                state <= 3'b000;
            end
        endcase
    end
end

endmodule
