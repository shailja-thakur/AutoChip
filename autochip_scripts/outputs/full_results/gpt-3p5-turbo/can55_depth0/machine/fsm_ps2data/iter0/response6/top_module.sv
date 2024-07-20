module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] out_reg;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_reg <= 0;
        state <= 0;
    end else begin
        case (state)
            0: begin // BYTE1
                if (in[2] == 1) begin
                    state <= 1;
                end else begin
                    state <= 0;
                end
            end
            1: begin // BYTE2
                state <= 2;
            end
            2: begin // BYTE3
                state <= 3;
            end
            3: begin // DONE
                if (in[2] == 0) begin
                    state <= 0;
                end else begin
                    state <= 3;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == 3) begin
        out_bytes <= out_reg;
    end
    out_reg <= {in, out_reg[23:8]};
end

assign done = (state == 3);

endmodule
