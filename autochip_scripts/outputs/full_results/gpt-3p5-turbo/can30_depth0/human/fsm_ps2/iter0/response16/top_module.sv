module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] buffer [0:2];
reg [7:0] byte_counter;
reg done_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        buffer <= 8'b0;
        byte_counter <= 0;
        done_reg <= 0;
    end else begin
        case(state)
            0: begin // Idle state, waiting for start of message
                if (in[3] == 1) begin
                    buffer[0] <= in;
                    byte_counter <= byte_counter + 1;
                    state <= 1;
                end
            end
            1: begin // Receive second byte
                buffer[1] <= in;
                byte_counter <= byte_counter + 1;
                state <= 2;
            end
            2: begin // Receive third byte
                buffer[2] <= in;
                byte_counter <= byte_counter + 1;
                state <= 3;
            end
            3: begin // Message received, check if all bytes were received
                if (byte_counter == 2) begin
                    done_reg <= 1;
                end
                state <= 0;
                byte_counter <= 0;
            end
        endcase
    end
end

assign done = done_reg;

endmodule
