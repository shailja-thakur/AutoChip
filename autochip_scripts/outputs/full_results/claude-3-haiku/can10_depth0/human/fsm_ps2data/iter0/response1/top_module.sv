module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam IDLE = 2'b00;
localparam WAIT_START = 2'b01;
localparam CAPTURE = 2'b10;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 3'b000;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= WAIT_START;
                    byte_count <= 3'b001;
                end
            end
            WAIT_START: begin
                if (in[3]) begin
                    state <= CAPTURE;
                    byte_count <= byte_count + 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    state <= IDLE;
                    byte_count <= 3'b000;
                end
            end
            CAPTURE: begin
                if (byte_count == 3'b011) begin
                    state <= IDLE;
                    byte_count <= 3'b000;
                    done <= 1'b1;
                end
                else begin
                    byte_count <= byte_count + 1;
                    case (byte_count)
                        3'b001: out_bytes[15:8] <= in;
                        3'b010: out_bytes[7:0] <= in;
                    endcase
                end
            end
            default: begin
                state <= IDLE;
                byte_count <= 3'b000;
            end
        endcase
    end
end

endmodule
