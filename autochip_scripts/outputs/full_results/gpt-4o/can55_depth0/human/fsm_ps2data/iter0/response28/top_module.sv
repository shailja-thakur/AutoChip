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
        BYTE1 = 2'b01, 
        BYTE2 = 2'b10, 
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] message;  // To store the 3-byte message

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Processing and next state logic
    always_comb begin
        next_state = state; // Default to stay in the same state
        done = 1'b0; // Default to done signal being deasserted
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                message[23:16] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                message[15:8] = in;
                next_state = BYTE3;
            end
            BYTE3: begin
                message[7:0] = in;
                next_state = IDLE;
                done = 1'b1; // Done signal asserted
            end
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else begin
            if (done) begin
                out_bytes <= message;
            end else begin
                out_bytes <= 24'bx; // Don't-care values at other times
            end
        end
    end

endmodule
