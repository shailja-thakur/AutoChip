module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    // State declarations
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t curr_state, next_state;
    reg [23:0] message;
    
    // Sequential state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            curr_state <= IDLE;
            message <= 24'b0;
            done <= 1'b0;
        end else begin
            curr_state <= next_state;
            if (next_state == BYTE3 && curr_state == BYTE2) begin
                done <= 1'b1;
                out_bytes <= {message[23:8], in};
            end else begin
                done <= 1'b0;
            end
        end
    end
    
    // Combinational next state logic
    always_comb begin
        next_state = curr_state;
        case (curr_state)
            IDLE: begin
                if (in[3] == 1) begin
                    message[23:16] = in;
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                message[15:8] = in;
                next_state = BYTE2;
            end
            BYTE2: begin
                message[7:0] = in;
                next_state = BYTE3;            
            end
            BYTE3: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
