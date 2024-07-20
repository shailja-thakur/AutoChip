module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state, next_state;
    reg [23:0] message;
    
    localparam IDLE    = 2'b00,
               BYTE1   = 2'b01,
               BYTE2   = 2'b10,
               BYTE3   = 2'b11;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: if (in[3]) next_state = BYTE1;
                  else next_state = IDLE;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and message register
    always @(posedge clk) begin
        if (reset) begin
            message <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                end
                BYTE1: begin
                    message[23:16] <= in;
                    done <= 0;
                end
                BYTE2: begin
                    message[15:8] <= in;
                    done <= 0;
                end
                BYTE3: begin
                    message[7:0] <= in;
                    out_bytes <= {message[23:8], in};
                    done <= 1;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end

endmodule
