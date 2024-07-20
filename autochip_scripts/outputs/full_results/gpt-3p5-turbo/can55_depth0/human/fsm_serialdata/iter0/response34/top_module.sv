module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

    enum {IDLE, START, DATA, STOP} state;
    reg [7:0] buffer; // buffer to store received data byte
    reg [2:0] bitCount; // tracks the count of received bits within a byte

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bitCount <= 0;
            buffer <= 0;
        end else begin
            case (state)
                IDLE:
                    if (in == 1)
                        state <= START;
                START:
                    if (bitCount < 8) begin
                        buffer[bitCount] <= in;
                        bitCount <= bitCount + 1;
                    end else
                        state <= STOP;
                DATA:
                    if (bitCount < 8) begin
                        buffer[bitCount] <= in;
                        bitCount <= bitCount + 1;
                    end else
                        state <= STOP;
                STOP:
                    if (bitCount == 8 && in == 1) begin
                        out_byte <= buffer;
                        bitCount <= 0;
                        state <= IDLE;
                    end else if (bitCount < 8) begin
                        buffer[bitCount] <= in;
                        bitCount <= bitCount + 1;
                        state <= DATA;
                    end else if (bitCount == 8 && in == 0) begin
                        bitCount <= 0; // discard partial byte
                        state <= STOP;
                    end else
                        state <= STOP;
            endcase
        end
    end

    assign done = (state == STOP);

endmodule
