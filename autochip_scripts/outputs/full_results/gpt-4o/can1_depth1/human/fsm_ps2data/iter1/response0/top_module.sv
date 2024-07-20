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
    reg [7:0] byte1, byte2, byte3;

    // Sequential state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            curr_state <= IDLE;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done <= 1'b0;
        end else begin
            curr_state <= next_state;
            done <= (next_state == IDLE && curr_state == BYTE3) ? 1'b1 : 1'b0;

            if (next_state == BYTE1) begin
                byte1 <= in;
            end else if (next_state == BYTE2) begin
                byte2 <= in;
            end else if (next_state == BYTE3) begin
                byte3 <= in;
                out_bytes <= {byte1, byte2, in};
            end
        end
    end
    
    // Combinational next state logic
    always_comb begin
        next_state = curr_state;
        case (curr_state)
            IDLE: begin
                if (in[3] == 1) begin
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
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
