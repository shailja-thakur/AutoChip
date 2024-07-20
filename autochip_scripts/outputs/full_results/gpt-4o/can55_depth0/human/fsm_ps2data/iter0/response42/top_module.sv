module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// State encoding
typedef enum logic [1:0] {
    IDLE = 2'b00,
    BYTE_1 = 2'b01,
    BYTE_2 = 2'b10,
    BYTE_3 = 2'b11
} state_t;

// Current state and next state
state_t current_state, next_state;

// Registers to hold incoming bytes
reg [23:0] message;

// Sequential state transition
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

// Combinational logic to decide next state and output done
always @(*) begin
    // Defaults
    next_state = current_state;
    done = 1'b0;
 
    case (current_state)
        IDLE: begin
            if (in[3]) next_state = BYTE_1;
        end
        BYTE_1: begin
            next_state = BYTE_2;
        end
        BYTE_2: begin
            next_state = BYTE_3;
        end
        BYTE_3: begin
            next_state = IDLE;
            done = 1'b1;
        end
    endcase
end

// Capture incoming bytes into message and update out_bytes
always @(posedge clk) begin
    if (reset) begin
        message <= 24'b0;
        out_bytes <= 24'b0;
    end else begin
        out_bytes <= 24'bx;  // Don't-care outputs
        case (next_state)
            BYTE_1: message[23:16] <= in;
            BYTE_2: message[15:8]  <= in;
            BYTE_3: message[7:0]   <= in;
        endcase
        if (done) out_bytes <= message;
    end
end

endmodule
