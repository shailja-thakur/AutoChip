module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

// Define states
typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
} state_t;

// Declare state and register
state_t state, next_state;
logic [7:0] register;

// Assign initial state
assign state = BYTE1;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        register <= 0;
    end else begin
        state <= next_state;
        register <= {register[15:0], in};
    end
end

// Determine next state and set outputs based on current state and input
always_comb begin
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = DONE;
        end
        DONE: begin
            next_state = BYTE1;
        end
        default: next_state = BYTE1;
    end

    if (state == DONE) begin
        done = 1;
        out_bytes = register;
    end else begin
        done = 0;
        out_bytes = 0;
    end
end

endmodule
