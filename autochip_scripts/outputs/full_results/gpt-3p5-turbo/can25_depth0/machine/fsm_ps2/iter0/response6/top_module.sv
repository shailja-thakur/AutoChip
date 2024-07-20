module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Define state enumeration
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_t;

// Declare state variable
state_t state, next_state;

// Register to store previous state
reg [1:0] prev_state;

// Assign initial state
initial begin
    state = BYTE1;
end

// Sequential logic for state transitions
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        state <= next_state;
    end
end

// Update next state based on current state and input
always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2] == 1'b1) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end

        BYTE2: next_state = BYTE3;

        BYTE3: next_state = DONE;

        DONE: begin
            if (in[2] == 1'b0) begin
                next_state = BYTE1;
            end else begin
                next_state = BYTE2;
            end
        end
    endcase
end

// Output logic
assign done = (state == DONE);

endmodule
