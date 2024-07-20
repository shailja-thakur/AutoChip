module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

// Initial state
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // BYTE1 state
    else begin
        case (state)
            2'b00: begin // BYTE1 state
                if (in[2] == 1) // Check if third bit is 1
                    state <= 2'b01; // BYTE2 state
                else
                    state <= 2'b00;
            end
            2'b01: begin // BYTE2 state
                state <= 2'b10; // BYTE3 state
            end
            2'b10: begin // BYTE3 state
                state <= 2'b11; // DONE state
            end
            2'b11: begin // DONE state
                if (in[2] == 0) // Check if third bit is 0
                    state <= 2'b00; // BYTE1 state
                else
                    state <= 2'b01; // BYTE2 state
            end
        endcase
    end
end

// Output done signal
always @(posedge clk) begin
    if (state == 2'b11) // DONE state
        done <= 1;
    else
        done <= 0;
end

endmodule
