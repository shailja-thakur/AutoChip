module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [7:0] byte_1; // First byte of message
    reg [7:0] byte_2; // Second byte of message
    reg [7:0] byte_3; // Third byte of message
    reg [2:0] state; // State variable

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0; // Reset state
            done <= 0; // Reset done signal
        end else begin
            case(state)
                0: begin // Idle state
                    if (in[3] == 1) begin // Check for message start
                        state <= 1;
                        byte_1 <= in; // Store first byte
                    end
                end
                1: begin // First byte received
                    state <= 2;
                    byte_2 <= in; // Store second byte
                end
                2: begin // Second byte received
                    state <= 3;
                    byte_3 <= in; // Store third byte
                end
                3: begin // Third byte received
                    state <= 0;
                    done <= 1; // Set done signal
                end
            endcase
        end
    end
    
    // Output assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 0; // Reset out_bytes
		end else begin
			if (state == 3) begin
				out_bytes <= {byte_1, byte_2, byte_3}; // Assign out_bytes when third byte is received
			end else begin
				out_bytes <= 0; // Hold the previous value of out_bytes
			end
		end
	end

endmodule
