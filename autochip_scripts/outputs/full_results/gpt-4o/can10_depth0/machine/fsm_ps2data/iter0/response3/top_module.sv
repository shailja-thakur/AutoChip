module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    typedef enum reg [1:0] {BYTE1, BYTE2, BYTE3, DONE} state_t;
    state_t state, next_state;
    reg [23:0] shift_reg;
 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            if (next_state != DONE) begin
                shift_reg <= {shift_reg[15:0], in};
            end
        end
    end

    always @(*) begin
        next_state = state;
        done = 0;
        out_bytes = 24'b0;
        
        case(state)
            BYTE1: begin
                if (in[2] == 1'b1)
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
                if (in[2] == 1'b0)
                    next_state = BYTE1;
                done = 1;
                out_bytes = shift_reg;
            end
            
            default: begin
                next_state = BYTE1;
            end
        endcase
    end
endmodule
