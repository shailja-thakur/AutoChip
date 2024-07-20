module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// State Definitions
typedef enum logic [1:0] {
    WAIT_FOR_FIRST_BYTE = 2'b00,
    RECEIVE_SECOND_BYTE = 2'b01,
    RECEIVE_THIRD_BYTE  = 2'b10
} state_t;

state_t state, next_state;

// Message byte storage
reg [7:0] byte1, byte2, byte3;
reg [23:0] message;

// State Transition
always_ff @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_FIRST_BYTE;
    end else begin
        state <= next_state;
    end
end

// Next State Logic
always_comb begin
    next_state = state; // Default
    done = 0;           // Default

    case (state)
        WAIT_FOR_FIRST_BYTE: begin
            if (in[3] == 1) begin
                next_state = RECEIVE_SECOND_BYTE;
            end
        end

        RECEIVE_SECOND_BYTE: begin
            next_state = RECEIVE_THIRD_BYTE;
        end

        RECEIVE_THIRD_BYTE: begin
            done = 1;
            next_state = WAIT_FOR_FIRST_BYTE;
        end
    endcase
end

// Output and Storage Logic
always_ff @(posedge clk) begin
    if (reset) begin
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        out_bytes <= 0;
    end else begin
        case (state)
            WAIT_FOR_FIRST_BYTE: begin
                if (in[3] == 1) begin
                    byte1 <= in;
                end
            end

            RECEIVE_SECOND_BYTE: begin
                byte2 <= in;
            end

            RECEIVE_THIRD_BYTE: begin
                byte3 <= in;
                out_bytes <= {byte1, byte2, byte3};
            end
        endcase
    end
end

endmodule
