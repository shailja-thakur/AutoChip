module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam IDLE = 2'b00;
localparam MSG_START = 2'b01;
localparam MSG_RCV = 2'b10;

reg [1:0] state, next_state;
reg [2:0] byte_count;

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
                    next_state <= MSG_START;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    next_state <= IDLE;
                    byte_count <= 0;
                    out_bytes <= 0;
                end
                done <= 0;
            end
            MSG_START: begin
                if (in[3]) begin
                    next_state <= MSG_RCV;
                    byte_count <= 2;
                    out_bytes[15:8] <= in;
                end
                else begin
                    next_state <= IDLE;
                    byte_count <= 0;
                    out_bytes <= 0;
                end
                done <= 0;
            end
            MSG_RCV: begin
                if (in[3]) begin
                    next_state <= IDLE;
                    byte_count <= 0;
                    out_bytes[7:0] <= in;
                    done <= 1;
                end
                else begin
                    next_state <= MSG_RCV;
                    byte_count <= byte_count + 1;
                    case (byte_count)
                        1: out_bytes[23:16] <= in;
                        2: out_bytes[15:8] <= in;
                        3: out_bytes[7:0] <= in;
                    endcase
                    done <= 0;
                end
            end
            default: begin
                next_state <= IDLE;
                byte_count <= 0;
                out_bytes <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
