module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define states
parameter BYTE1 = 0;
parameter BYTE2 = 1;
parameter BYTE3 = 2;
parameter DONE = 3;

// Define variables
reg [1:0] state;
reg done;

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= BYTE1;
    else begin
        case (state)
            BYTE1: begin
                if (in[2])
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
            BYTE2: state <= BYTE3;
            BYTE3: state <= DONE;
            DONE: begin
                if (in[2])
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
        endcase
    end
end

// Output logic
always @(posedge clk) begin
    if (state == DONE)
        done <= 1;
    else
        done <= 0;
end

endmodule
