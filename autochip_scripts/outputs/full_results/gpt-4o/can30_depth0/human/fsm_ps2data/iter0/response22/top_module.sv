module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    reg [23:0] message;
    
    always_ff @(posedge clk) begin
        if (reset) 
            current_state <= IDLE;
        else 
            current_state <= next_state;
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            message <= 24'd0;
            out_bytes <= 24'd0;
        end
        else if (done) 
            out_bytes <= message;
    end
    
    always_comb begin
        next_state = current_state;
        done = 0;
        case (current_state)
            IDLE: begin
                if (in[3]) 
                    next_state = BYTE1;
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
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
