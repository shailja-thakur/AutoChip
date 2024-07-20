module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] message;
    reg [7:0] byte1, byte2, byte3;
    reg [1:0] byte_count;

    // State encoding
    localparam IDLE  = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;
    
    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
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
        endcase
    end

    // Output logic and byte counting
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'd0;
            done <= 0;
            byte1 <= 0;
            byte2 <= 0;
            byte3 <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    byte_count <= 0;
                    if (in[3] == 1) begin
                        byte1 <= in;
                    end
                end
                BYTE1: begin
                    byte2 <= in;
                    byte_count <= 1;
                end
                BYTE2: begin
                    byte3 <= in;
                    byte_count <= 2;
                end
                BYTE3: begin
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
            endcase
        end
    end

endmodule
