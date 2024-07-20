module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] reg_bytes;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default values for outputs and next state
        next_state = state;
        done = 1'b0;
        
        case (state)
            BYTE1: begin
                if (in[2]) 
                    next_state = BYTE2;
                else 
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (in[2]) 
                    next_state = DONE;
                else 
                    next_state = BYTE1;
            end
            default: next_state = BYTE1;
        endcase
    end

    // Sequential logic for output bytes update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_bytes <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            if (state == BYTE1 || state == BYTE2 || state == BYTE3) begin
                reg_bytes <= {reg_bytes[15:0], in};
                out_bytes <= 24'b0;
            end else if (state == DONE) begin
                out_bytes <= reg_bytes;
            end
        end
    end

endmodule
