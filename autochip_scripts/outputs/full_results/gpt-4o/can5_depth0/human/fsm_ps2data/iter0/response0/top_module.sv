module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    
    // State encoding
    localparam IDLE = 2'b00, 
               BYTE1 = 2'b01, 
               BYTE2 = 2'b10, 
               BYTE3 = 2'b11;

    // State transition logic
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
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
        endcase
    end

    // Output and message capturing logic
    always @(posedge clk) begin
        if (reset) begin
            message <= 24'b0;
            done <= 1'b0;
            out_bytes <= 24'b0;
        end
        else begin
            done <= 1'b0;
            case (state)
                IDLE: begin
                    // No need to capture anything
                end

                BYTE1: begin
                    message[23:16] <= in;
                end

                BYTE2: begin
                    message[15:8] <= in;
                end

                BYTE3: begin
                    message[7:0] <= in;
                    out_bytes <= message | in; // Complete message available at out_bytes
                    done <= 1'b1; // Signal done when we have the third byte
                end
            endcase
        end
    end

endmodule
