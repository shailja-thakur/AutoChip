module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    reg [3:0] state, next_state;
    reg [23:0] message;
    reg [1:0] byte_count;

    // Define FSM states
    localparam WAIT_START = 4'b0001,
               BYTE1      = 4'b0010,
               BYTE2      = 4'b0100,
               BYTE3      = 4'b1000;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_START;
        end 
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            WAIT_START: begin
                if (in[3] == 1) next_state = BYTE1;
                else next_state = WAIT_START;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = WAIT_START;
            default: next_state = WAIT_START;
        endcase
    end

    // Output and internal registers logic
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            done <= 1'b0;
            message <= 24'b0; 
            byte_count <= 2'b0;
        end
        else begin
            case (state)
                WAIT_START: begin
                    done <= 1'b0;
                end
                BYTE1: begin
                    message[23:16] <= in;
                    byte_count <= 2'b01;
                end
                BYTE2: begin
                    message[15:8] <= in;
                    byte_count <= 2'b10;
                end
                BYTE3: begin
                    message[7:0] <= in;
                    byte_count <= 2'b11;
                    out_bytes <= {message[23:16], message[15:8], in};
                    done <= 1'b1;
                end
            endcase

            if (state == BYTE3 && !reset) begin
                done <= 1'b1;
            end
            else begin
                done <= 1'b0;
            end
        end
    end

endmodule
