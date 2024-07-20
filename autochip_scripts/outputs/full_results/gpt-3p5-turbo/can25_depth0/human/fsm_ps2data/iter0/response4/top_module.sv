module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [23:0] message;
reg [7:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        message <= 0;
        byte_count <= 0;
        done <= 0;
        out_bytes <= 0;
    end else begin
        case (state)
            0: begin // Idle state
                if (in[3]) begin
                    byte_count <= 1;
                    message[23:16] <= in;
                    state <= 1;
                end
            end
            1: begin // Receiving byte 2
                byte_count <= byte_count + 1;
                message[15:8] <= in;
                if (byte_count == 2) begin
                    state <= 2;
                end
            end
            2: begin // Receiving byte 3
                byte_count <= byte_count + 1;
                message[7:0] <= in;
                if (byte_count == 3) begin
                    done <= 1;
                    out_bytes <= message;
                    state <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end

endmodule
