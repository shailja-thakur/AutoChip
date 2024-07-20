module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
); 

    // State enumeration
    localparam IDLE  = 2'd0;
    localparam BYTE1 = 2'd1;
    localparam BYTE2 = 2'd2;
    localparam BYTE3 = 2'd3;

    reg [1:0] state, next_state;
    reg [7:0] byte1, byte2, byte3;

    // State transitions
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
            IDLE: next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = (in[3] == 1'b1) ? BYTE1 : IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and message latching
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (next_state == BYTE1) begin
                        done <= 1'b0;
                    end
                end
                BYTE1: begin
                    byte1 <= in;
                    done <= 1'b0;
                end
                BYTE2: begin
                    byte2 <= in;
                    done <= 1'b0;
                end
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, in};
                    done <= 1'b1;
                end
            endcase
            
            // Clear the done signal one cycle after it is set
            if (done == 1'b1) begin
                done <= 1'b0;
            end else if (state == BYTE3) begin
                done <= 1'b1;
            end
        end
    end

endmodule
