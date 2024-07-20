module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State definitions
    localparam IDLE = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;
    reg [1:0] state, next_state;
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    // Output and message register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (next_state)
                IDLE: begin
                    done <= 0;
                end
                BYTE1: begin
                    out_bytes[23:16] <= in;
                    done <= 0;
                end
                BYTE2: begin
                    out_bytes[15:8] <= in;
                    done <= 0;
                end
                BYTE3: begin
                    out_bytes[7:0] <= in;
                    done <= 1;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end
endmodule
