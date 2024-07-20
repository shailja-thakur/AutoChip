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

    localparam IDLE = 2'd0,
               BYTE1 = 2'd1,
               BYTE2 = 2'd2,
               BYTE3 = 2'd3;

    // State transition
    always @(posedge clk) begin
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
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    // State actions and output logic
    always @(posedge clk) begin
        if (reset) begin
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
            out_bytes <= 24'd0;
            done <= 0;
        end else begin
            done <= 0;
            case (state)
                IDLE: begin
                    // Reset or no action
                end
                BYTE1: begin
                    byte1 <= in;
                end
                BYTE2: begin
                    byte2 <= in;
                end
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
            endcase
        end
    end

endmodule
