module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state;
wire third_bit;

assign third_bit = in[2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        done <= 0;
    end else begin
        case(state)
            BYTE1: begin
                if (third_bit == 1'b1)
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
            BYTE2: begin
                state <= BYTE3;
            end
            BYTE3: begin
                state <= DONE;
            end
            DONE: begin
                if (third_bit == 1'b0)
                    state <= BYTE1;
                else
                    state <= DONE;
            end
            default: begin
                state <= BYTE1;
                done <= 0;
            end
        endcase
    end
end

always @(posedge clk) begin
    case(state)
        BYTE1: begin
            out_bytes <= {in, out_bytes[23:8]};
        end
        BYTE2: begin
            out_bytes <= {8'b0, in, out_bytes[23:16]};
        end
        BYTE3: begin
            out_bytes <= {16'b0, in, out_bytes[23:0]};
        end
        default: begin
            out_bytes <= 24'b0;
        end
    endcase
end

always @(posedge clk) begin
    if (state == DONE) begin
        done <= 1;
    end else begin
        done <= 0;
    end
end

endmodule
