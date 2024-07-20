module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_reg;
	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= BYTE1;
			out_reg <= 0;
		end else begin
            case (state)
                BYTE1: begin
                    if (in[2] == 1) begin
                        state <= BYTE2;
                        out_reg <= {in, 8'b0};
                    end else if (done) begin
                        state <= BYTE1;
                        out_reg <= out_reg << 8;
                    end
                end
                BYTE2: begin
                    if (in[2] == 1) begin
                        state <= BYTE3;
                        out_reg <= {in, 8'b0};
                    end else if (done) begin
                        state <= BYTE1;
                        out_reg <= out_reg << 8;
                    end
                end
                BYTE3: begin
                    if (in[2] == 1) begin
                        state <= DONE;
                        out_reg <= {in, 8'b0};
                    end else if (done) begin
                        state <= BYTE1;
                        out_reg <= out_reg << 8;
                    end
                end
                DONE: begin
                    state <= BYTE1;
                    out_reg <= out_reg << 8;
                end
            endcase
        end
	end

	assign out_bytes = out_reg;
	assign done = (state == DONE);

endmodule
