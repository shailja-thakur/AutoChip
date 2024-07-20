module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] byte_accumulator;

    localparam IDLE = 2'd0,
               BYTE1 = 2'd1,
               BYTE2 = 2'd2,
               BYTE3 = 2'd3;

    // State transition logic
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
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
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
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic and register updates
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            byte_accumulator <= 24'b0;
            done <= 1'b0;
        end else begin
            done <= 1'b0; // Reset the done signal by default
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        byte_accumulator[23:16] <= in;
                    end
                end
                BYTE1: begin
                    byte_accumulator[15:8] <= in;
                end
                BYTE2: begin
                    byte_accumulator[7:0] <= in;
                end
                BYTE3: begin
                    out_bytes <= {byte_accumulator[23:8], in};
                    done <= 1'b1;
                end
            endcase
        end
    end

endmodule
