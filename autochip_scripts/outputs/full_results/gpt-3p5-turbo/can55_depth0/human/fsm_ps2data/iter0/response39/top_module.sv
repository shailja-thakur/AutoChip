module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg done_reg;
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 8'h00;
        byte2 <= 8'h00;
        byte3 <= 8'h00;
        state <= 2'b00;
        done_reg <= 1'b0;
    end else begin
        case (state)
            2'b00: begin // Waiting for first byte
                if (in[3]) begin
                    byte1 <= in;
                    state <= 2'b01;
                end
            end
            2'b01: begin // Waiting for second byte
                byte2 <= in;
                state <= 2'b10;
            end
            2'b10: begin // Waiting for third byte
                byte3 <= in;
                state <= 2'b11;
            end
            2'b11: begin // Done receiving bytes
                done_reg <= 1'b1;
            end
        endcase
    end
end

// Output the message bytes when done is asserted
always @(posedge clk) begin
    if (reset) begin
        out_bytes <= 24'h0;
    end else begin
        if (done_reg) begin
            out_bytes <= {byte3, byte2, byte1};
        end
    end
end

// Assert done at the immediate cycle after the third byte is received
always @(posedge clk) begin
    if (reset) begin
        done <= 1'b0;
    end else begin
        done <= done_reg;
    end
end

endmodule
