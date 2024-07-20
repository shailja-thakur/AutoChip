module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Define states for the FSM
typedef enum logic [2:0] {
    IDLE,
    FIND_START,
    RECEIVE_BYTE2,
    RECEIVE_BYTE3,
    DONE
} state_t;

// Define signals for the FSM
reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

// Assign initial values to signals
initial begin
    state = IDLE;
    byte1 = 8'b0;
    byte2 = 8'b0;
    byte3 = 8'b0;
end

// FSM logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    byte1 <= in;
                    state <= FIND_START;
                end
            end
            FIND_START: begin
                if (in[3]) begin
                    byte1 <= in;
                    state <= FIND_START;
                end else begin
                    byte2 <= in;
                    state <= RECEIVE_BYTE2;
                end
            end
            RECEIVE_BYTE2: begin
                byte3 <= in;
                state <= RECEIVE_BYTE3;
            end
            RECEIVE_BYTE3: begin
                if (in[3]) begin
                    byte1 <= in;
                    state <= FIND_START;
                    done <= 1'b1;
                end else begin
                    byte2 <= in;
                    state <= RECEIVE_BYTE2;
                end
            end
            DONE: begin
                done <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
