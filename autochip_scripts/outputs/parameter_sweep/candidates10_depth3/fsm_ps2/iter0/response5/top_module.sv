module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1; // First byte of the message
reg [7:0] byte2; // Second byte of the message
reg [7:0] byte3; // Third byte of the message

reg [2:0] state; // FSM state

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0; // Initialize state to 0 during reset
        byte1 <= 0; // Reset byte1
        byte2 <= 0; // Reset byte2
        byte3 <= 0; // Reset byte3
        done <= 0;  // Reset done
    end
    else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    byte1 <= in; // Store the first byte
                    state <= 1; // Move to state 1
                end
            end
            1: begin
                byte2 <= in; // Store the second byte
                state <= 2; // Move to state 2
            end
            2: begin
                byte3 <= in; // Store the third byte
                state <= 3; // Move to state 3
            end
            3: begin
                if (in[3] == 1) begin
                    done <= 1;  // Signal the receipt of the message
                end
                byte1 <= in; // Store the first byte for the next message
                state <= 1; // Move back to state 1
            end
        endcase
    end
end

endmodule
