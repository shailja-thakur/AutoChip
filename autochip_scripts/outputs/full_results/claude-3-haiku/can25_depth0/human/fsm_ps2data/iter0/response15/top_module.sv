module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] IDLE = 2'b00, SEARCH = 2'b01, RECEIVE = 2'b10;
reg [1:0] state, next_state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state <= RECEIVE;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    next_state <= SEARCH;
                    byte_count <= 0;
                end
                done <= 0;
            end
            SEARCH: begin
                if (in[3]) begin
                    next_state <= RECEIVE;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    next_state <= SEARCH;
                    byte_count <= 0;
                end
                done <= 0;
            end
            RECEIVE: begin
                case (byte_count)
                    1: begin
                        out_bytes[15:8] <= in;
                        byte_count <= 2;
                        next_state <= RECEIVE;
                    end
                    2: begin
                        out_bytes[7:0] <= in;
                        byte_count <= 3;
                        next_state <= IDLE;
                        done <= 1;
                    end
                    3: begin
                        // Should never reach here
                        next_state <= IDLE;
                        byte_count <= 0;
                        done <= 0;
                    end
                    default: begin
                        // Should never reach here
                        next_state <= IDLE;
                        byte_count <= 0;
                        done <= 0;
                    end
                endcase
            end
            default: begin
                // Should never reach here
                next_state <= IDLE;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
