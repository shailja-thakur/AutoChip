module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [1:0] state;
reg [23:0] message;
reg [2:0] byte_counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte_counter <= 0;
        message <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Discard bytes until in[3] is 1
                if (in[3] == 1) begin
                    state <= 1;
                    byte_counter <= 0;
                    message <= {16'd0, in};
                end else begin
                    state <= 0;
                    byte_counter <= 0;
                    message <= 0;
                end
            end
            1: begin // Receive first byte of message
                if (byte_counter == 2) begin
                    state <= 2;
                    byte_counter <= byte_counter + 1;
                    message[7:0] <= in;
                end else begin
                    byte_counter <= byte_counter + 1;
                    message[23:16] <= in;
                end
            end
            2: begin // Receive second byte of message
                if (byte_counter == 2) begin
                    state <= 3;
                    byte_counter <= byte_counter + 1;
                    message[15:8] <= in;
                end else begin
                    byte_counter <= byte_counter + 1;
                    message[7:0] <= in;
                end
            end
            3: begin // Receive third byte of message
                if (byte_counter == 2) begin
                    state <= 4;
                    byte_counter <= 0;
                    message[23:16] <= in;
                end else begin
                    byte_counter <= byte_counter + 1;
                    message[15:8] <= in;
                end
            end
            4: begin // Message received, set done to 1
                state <= 0;
                byte_counter <= 0;
                message <= 0;
                done <= 1;
            end
            default: begin
                state <= 0;
                byte_counter <= 0;
                message <= 0;
                done <= 0;
            end
        endcase
    end
end

assign out_bytes = message;

endmodule
