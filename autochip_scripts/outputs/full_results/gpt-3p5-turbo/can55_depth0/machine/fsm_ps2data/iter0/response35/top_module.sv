module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

    reg [23:0] out_reg;
    reg [2:0] state;
    reg done_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_reg <= 0;
            state <= 3'b000;
            done_reg <= 0;
        end else begin
            case(state)
                3'b000: begin // BYTE1
                    if(in[2] == 1'b1) begin
                        state <= 3'b001; // BYTE2
                    end else begin
                        state <= 3'b000; // Stay in BYTE1
                    end
                end
                3'b001: begin // BYTE2
                    state <= 3'b010; // BYTE3
                end
                3'b010: begin // BYTE3
                    state <= 3'b011; // DONE
                end
                3'b011: begin // DONE
                    if(in[2] == 1'b0) begin
                        state <= 3'b000; // BYTE1
                    end else begin
                        state <= 3'b011; // Stay in DONE
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if(done_reg == 1'b1) begin
            out_bytes <= out_reg;
        end
    end

    always @(posedge clk) begin
        out_reg <= {out_reg[15:0], in};
    end

    always @(posedge clk) begin
        if(state == 3'b011) begin // DONE
            done <= 1;
        end else begin
            done <= 0;
        end
    end

endmodule
