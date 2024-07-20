module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

    // Define state variables
    reg [1:0] state;
    reg done_out;

    // Define states
    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE = 2'b11;

    // State machine logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            case(state)
                BYTE1: begin
                    if (in[2] == 1) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                end
                BYTE2: begin
                    state <= BYTE3;
                end
                BYTE3: begin
                    state <= DONE;
                end
                DONE: begin
                    if (in[2] == 1) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(state) begin
        done_out = (state == DONE);
    end

    // Assign output ports
    assign done = done_out;

endmodule
