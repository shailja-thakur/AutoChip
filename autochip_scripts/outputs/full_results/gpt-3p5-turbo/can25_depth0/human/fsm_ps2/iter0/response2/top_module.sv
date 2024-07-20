module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] buffer [2:0];
wire start;

assign start = (in[3] == 1);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        buffer <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Searching for start of message
                if (start) begin
                    state <= 1;
                    buffer[0] <= in;
                end
            end
            1: begin // Receiving second byte of message
                state <= 2;
                buffer[1] <= in;
            end
            2: begin // Receiving third byte of message
                state <= 0;
                buffer[2] <= in;
                done <= 1;
            end
        endcase
    end
end

endmodule
