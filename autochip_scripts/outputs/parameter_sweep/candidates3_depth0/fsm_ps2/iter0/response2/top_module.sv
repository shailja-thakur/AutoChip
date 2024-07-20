module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [1:0] state; // FSM state
reg [7:0] byte_count; // Number of bytes received in a message

// Synchronous reset
always @(posedge clk) begin
    if (reset)
        state <= 2'b00;
    else
        case (state)
            2'b00: begin // Idle state
                if (in[3]) // Check if start of message
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin // Receiving state
                byte_count <= byte_count + 1; // Increment byte count
                if (byte_count == 2) // Check if all 3 bytes received
                    state <= 2'b10;
                else
                    state <= 2'b01;
            end
            2'b10: begin // Done state
                state <= 2'b00;
            end
        endcase
    end

// Output
assign done = (state == 2'b10);

endmodule
