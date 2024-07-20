module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

// Declare the states using an enumerated data type
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_t;

// Declare registers for the current state and next state
reg state_t current_state, next_state;

// Register for the output signal
reg done_reg;

// Assign the next state based on the current state and input conditions
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        current_state <= BYTE1;
    end else begin
        current_state <= next_state;
    end
end

// Assign the next state and output based on the current state and input conditions
always_comb begin
    case (current_state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
            done_reg = 0;
        end
        BYTE2: begin
            next_state = BYTE3;
            done_reg = 0;
        end
        BYTE3: begin
            next_state = DONE;
            done_reg = 0;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
            done_reg = 1;
        end
        default: begin
            next_state = BYTE1;
            done_reg = 0;
        end
    endcase
end

// Assign the output signal from the registered output signal
assign done = done_reg;

endmodule
