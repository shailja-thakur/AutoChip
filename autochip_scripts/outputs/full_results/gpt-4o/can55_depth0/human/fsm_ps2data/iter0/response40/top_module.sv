module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    // State encoding
    typedef enum logic [1:0] {
        S_IDLE    = 2'b00,
        S_BYTE1   = 2'b01,
        S_BYTE2   = 2'b10,
        S_BYTE3   = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] message;
    
    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        
        case (state)
            S_IDLE: begin
                if (in[3])
                    next_state = S_BYTE1;
            end
            
            S_BYTE1: next_state = S_BYTE2;
            S_BYTE2: next_state = S_BYTE3;
            S_BYTE3: begin
                next_state = S_IDLE;
                done = 1;
            end
        endcase
    end
    
    // Output logic and message assembly
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
        end else begin
            if (state == S_IDLE)
                message <= 24'b0;
                
            if (state != S_IDLE)
                message <= {message[15:0], in};
                
            if (done)
                out_bytes <= {message[15:0], in};
        end
    end
endmodule
