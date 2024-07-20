module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    reg [1:0] state, next_state;
    reg [23:0] temp_bytes;
    reg [1:0] byte_count;

    localparam IDLE  = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) next_state = BYTE1;
                else next_state = IDLE;
            end
            
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            temp_bytes <= 24'b0;
            byte_count <= 2'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            done <= 1'b0; // Default done signal
            case (state)
                IDLE: begin
                    byte_count <= 2'b0;
                end
                
                BYTE1: begin
                    temp_bytes[23:16] <= in;
                    byte_count <= 2'b01;
                end
                
                BYTE2: begin
                    temp_bytes[15:8] <= in;
                    byte_count <= 2'b10;
                end
                
                BYTE3: begin
                    temp_bytes[7:0] <= in;
                    out_bytes <= temp_bytes;
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
