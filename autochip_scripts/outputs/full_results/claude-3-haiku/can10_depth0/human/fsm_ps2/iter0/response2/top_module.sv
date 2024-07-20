module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
parameter WAIT_START = 2'b00,
          RECV_BYTE1 = 2'b01,
          RECV_BYTE2 = 2'b10,
          RECV_BYTE3 = 2'b11;

// State registers
reg [1:0] state, next_state;

// Message byte registers
reg [7:0] byte1, byte2, byte3;

// FSM transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
    end else begin
        state <= next_state;
    end
end

// FSM output logic
always @(*) begin
    case (state)
        WAIT_START: begin
            if (in[3]) begin
                next_state = RECV_BYTE1;
                byte1 = in;
            end else begin
                next_state = WAIT_START;
            end
            done = 0;
        end
        RECV_BYTE1: begin
            next_state = RECV_BYTE2;
            byte2 = in;
            done = 0;
        end
        RECV_BYTE2: begin
            next_state = RECV_BYTE3;
            byte3 = in;
            done = 0;
        end
        RECV_BYTE3: begin
            next_state = WAIT_START;
            done = 1;
        end
    endcase
end

endmodule
