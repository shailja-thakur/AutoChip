module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;
reg done_next;
reg [7:0] prev_in;
reg [2:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done_next <= 0;
        byte_count <= 0;
    end else begin
        case(state)
            0: begin  // Idle state, waiting for first byte of message
                if (in[3] == 1 && byte_count == 0) begin
                    state <= 1;
                    byte_count <= byte_count + 1;
                end
            end
            1: begin  // Received first byte, waiting for second byte
                state <= 2;
                byte_count <= byte_count + 1;
            end
            2: begin  // Received second byte, waiting for third byte
                state <= 3;
                byte_count <= byte_count + 1;
            end
            3: begin  // Received third byte, message complete
                state <= 0;
                done_next <= 1;
                byte_count <= 0;
            end
        endcase
        prev_in <= in;
    end
end

always @(posedge clk) begin
    if (byte_count == 3) begin
        done <= done_next;
        done_next <= 0;
    end else begin
        done <= 0;
    end
end

endmodule
