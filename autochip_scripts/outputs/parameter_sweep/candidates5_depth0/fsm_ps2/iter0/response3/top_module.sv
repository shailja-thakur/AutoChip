module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] prev_byte;
reg done;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Initial state
                if (in[3]) begin
                    prev_byte <= in;
                    state <= 1;
                end
            end
            1: begin // Waiting for byte 2
                if (in[3]) begin
                    prev_byte <= in;
                    state <= 2;
                end else begin
                    state <= 0;
                end
            end
            2: begin // Waiting for byte 3
                if (in[3]) begin
                    state <= 0;
                    done <= 1;
                end else begin
                    state <= 0;
                end
            end
            default: begin
                state <= 0;
            end
        endcase
    end
end

endmodule
