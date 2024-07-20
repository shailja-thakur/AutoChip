module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] bytes_reg;
    
    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: if (in[2]) 
                       next_state = BYTE2; 
                   else 
                       next_state = BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  if (in[2]) 
                       next_state = DONE; 
                   else 
                       next_state = BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            bytes_reg <= 24'd0;
            out_bytes <= 24'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            case (next_state)
                BYTE1: begin
                    if (state != DONE) begin
                        bytes_reg <= {bytes_reg[15:0], in};
                    end
                end
                BYTE2: bytes_reg <= {bytes_reg[15:0], in};
                BYTE3: bytes_reg <= {bytes_reg[15:0], in};
                DONE: begin
                    if (state == BYTE3) begin
                        out_bytes <= bytes_reg;
                    end
                    done <= 1'b1;
                end
            endcase
            if (state != DONE) begin
                done <= 1'b0;
            end
        end
    end
endmodule
