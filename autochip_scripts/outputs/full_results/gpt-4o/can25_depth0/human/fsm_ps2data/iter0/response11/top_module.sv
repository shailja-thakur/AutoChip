module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // States
    typedef enum logic [1:0] {
        IDLE = 2'b00, 
        BYTE1 = 2'b01, 
        BYTE2 = 2'b10, 
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] message;
    
    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        done = 1'b0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1'b1;
            end
        endcase
    end

    // Output and data path logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
        end else begin
            case (state)
                IDLE: begin
                    message <= {16'b0, in}; // Load the first byte
                end
                BYTE1: begin
                    message <= {message[15:0], in}; // Load the second byte
                end
                BYTE2: begin
                    message <= {message[7:0], in}; // Load the third byte
                end
                BYTE3: begin
                    out_bytes <= {message[7:0], in}; // Complete the message
                end
            endcase
        end
    end

endmodule
