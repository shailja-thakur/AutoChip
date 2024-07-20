module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte_1;
reg [7:0] byte_2;
reg [7:0] byte_3;

reg [2:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
    end else begin
        case (state)
            0: begin // Wait for start of message
                if (in[3] == 1) begin
                    byte_1 <= in;
                    state <= 1;
                end
            end
            1: begin // Receive byte 2
                byte_2 <= in;
                state <= 2;
            end
            2: begin // Receive byte 3 and signal done
                byte_3 <= in;
                state <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
