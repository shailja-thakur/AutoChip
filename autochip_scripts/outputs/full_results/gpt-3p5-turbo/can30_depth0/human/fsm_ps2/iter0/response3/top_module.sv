module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] buffer [0:2];     // Buffer to store the three bytes of the message
reg [4:0] state;             // Current state of the FSM

// State definitions
parameter IDLE = 3'b000;
parameter BYTE1 = 3'b001;
parameter BYTE2 = 3'b010;
parameter BYTE3 = 3'b011;
parameter DONE = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset values
        state <= IDLE;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin           // Check if in[3] is 1
                    buffer[0] <= in;       // Store byte 1 into buffer
                    state <= BYTE1;
                end
            end

            BYTE1: begin
                buffer[1] <= in;           // Store byte 2 into buffer
                state <= BYTE2;
            end

            BYTE2: begin
                buffer[2] <= in;           // Store byte 3 into buffer
                state <= BYTE3;
            end

            BYTE3: begin
                done <= 1;                 // Signal the receipt of a message
                state <= DONE;
            end

            DONE: begin
                done <= 0;                 // Reset done signal
                state <= IDLE;             // Go back to IDLE state to search for next message
            end
        endcase
    end
end

endmodule
