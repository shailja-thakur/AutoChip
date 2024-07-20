module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State Declaration
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] temp_out_bytes;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            out_bytes <= temp_out_bytes;
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = state; // default
        temp_out_bytes = out_bytes; // holding value
        done = 1'b0;

        case (state)
            BYTE1: begin
                if (in[2] == 1'b1) 
                    next_state = BYTE2;
                temp_out_bytes = {temp_out_bytes[15:0], in};
            end
            BYTE2: begin
                next_state = BYTE3;
                temp_out_bytes = {temp_out_bytes[15:0], in};
            end
            BYTE3: begin
                next_state = DONE;
                temp_out_bytes = {temp_out_bytes[15:0], in};
            end
            DONE: begin
                done = 1'b1;
                if (in[2] == 1'b0)
                    next_state = BYTE1;
            end
        endcase
    end
endmodule
