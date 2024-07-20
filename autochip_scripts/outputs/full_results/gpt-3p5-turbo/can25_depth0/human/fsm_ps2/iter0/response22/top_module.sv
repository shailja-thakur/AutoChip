module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Declare FSM states
typedef enum logic [1:0] {
    WAIT_FOR_START, // Waiting for first byte with in[3]=1
    RECEIVE_BYTE1, // Receiving byte 1
    RECEIVE_BYTE2, // Receiving byte 2
    RECEIVE_BYTE3 // Receiving byte 3
} state_t;

// Declare signals
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [1:0] state;

// Next state and output logic
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_FOR_START;
    end else begin
        case (state)
            WAIT_FOR_START:
                if (in[3]) begin
                    byte1 <= in;
                    state <= RECEIVE_BYTE2;
                end
            RECEIVE_BYTE1:
                byte1 <= in;
                state <= RECEIVE_BYTE2;
            RECEIVE_BYTE2:
                byte2 <= in;
                state <= RECEIVE_BYTE3;
            RECEIVE_BYTE3:
                byte3 <= in;
                state <= WAIT_FOR_START;
        endcase
    end
end

// Output logic for done signal
assign done = (state == RECEIVE_BYTE3);

endmodule
