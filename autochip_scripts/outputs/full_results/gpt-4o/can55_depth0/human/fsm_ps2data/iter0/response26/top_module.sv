module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // State encoding
    parameter IDLE = 2'b00;
    parameter BYTE1 = 2'b01;
    parameter BYTE2 = 2'b10;
    parameter BYTE3 = 2'b11;
    
    reg [1:0] state, next_state;
    reg [23:0] message;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in[3] == 1) 
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;
                done = 1;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            message <= 24'b0;
            out_bytes <= 24'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1)
                        message[23:16] <= in;
                end
                BYTE1: begin
                    message[15:8] <= in;
                end
                BYTE2: begin
                    message[7:0] <= in;
                end
                BYTE3: begin
                    out_bytes <= message;
                end
            endcase
        end
    end
endmodule
