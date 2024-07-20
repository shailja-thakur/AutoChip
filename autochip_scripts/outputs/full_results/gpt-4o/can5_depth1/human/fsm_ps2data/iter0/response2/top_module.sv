module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        WAITING  = 2'b00,
        BYTE1    = 2'b01,
        BYTE2    = 2'b10,
        BYTE3    = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // Internal buffers for bytes
    reg [7:0] byte1, byte2, byte3;

    // State register
    always @(posedge clk) begin
        if (reset) begin
            current_state <= WAITING;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            WAITING: begin
                if (in[3]) begin
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
                next_state = WAITING;
            end
            default: begin
                next_state = WAITING;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            done <= 0;
            case (current_state)
                WAITING: begin
                    if (in[3]) begin
                        byte1 <= in;
                    end
                end
                BYTE1: begin
                    byte2 <= in;
                end
                BYTE2: begin
                    byte3 <= in;
                end
                BYTE3: begin
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
            endcase
        end
    end

endmodule
